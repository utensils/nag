FROM msaraiva/elixir-dev:latest
MAINTAINER Sean Callan <scallan@wombatsecurity.com>

# Install Goon for Porcelain
RUN wget --no-check-certificate https://github.com/alco/goon/releases/download/v1.1.1/goon_linux_amd64.tar.gz \
  && tar -xvzf goon_linux_amd64.tar.gz \
  && mv goon /usr/bin/goon \
  && rm goon_linux_amd64.tar.gz

# Install Docker daemon
RUN apk add --no-cache \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
      docker

# Elixir dependencies
RUN mix local.hex --force \
  && mix deps.get \
  && MIX_ENV=prod mix compile

# Setup Ruby and install Gems
RUN apk --update add --virtual build-dependencies \
     build-base cmake gcc libffi-dev ruby-dev libstdc++ \
  && apk add git nodejs openssh ruby ruby-irb ruby-rake \
    ruby-io-console ruby-bigdecimal \
  && echo 'gem: --no-rdoc --no-ri' > /etc/gemrc \
  && gem install bundler \
  && rm -r /root/.gem \
  && curl https://curl.haxx.se/ca/cacert.pem -o "$(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE')" \
  && bundle install \
  && apk del build-dependencies \
  && mkdir /app

# Install Credo
RUN git clone https://github.com/rrrene/credo.git \
  && cd credo \
  && mix local.hex --force \
  && mix deps.get \
  && mix archive.build \
  && mix archive.install --force \
  && cd .. \
  && rm -rf credo

RUN mkdir /app
ADD ./ /app/
RUN chmod 755 /app/docker-entrypoint.sh
WORKDIR /app

EXPOSE 4000

CMD ["/app/docker-entrypoint.sh"]
