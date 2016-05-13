FROM msaraiva/elixir-dev:latest
MAINTAINER Sean Callan <scallan@wombatsecurity.com>

ADD Gemfile /Gemfile

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

ADD docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod 755 /app/docker-entrypoint.sh
WORKDIR /app

CMD ["/app/docker-entrypoint.sh"]
