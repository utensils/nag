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

RUN mkdir /app
ADD ./ /app/
RUN chmod 755 /app/docker-entrypoint.sh
WORKDIR /app

# Elixir dependencies
RUN mix local.hex --force \
  && mix deps.get \
  && MIX_ENV=prod mix compile

ENV DOCKER_HOST unix:///tmp/docker.sock

EXPOSE 4000

CMD ["/app/docker-entrypoint.sh"]
