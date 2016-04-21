FROM cybercode/alpine-ruby:2.2

ADD Gemfile /Gemfile

RUN apk --update add --virtual build-dependencies \
  build-base ruby-dev cmake libffi-dev \
  && apk add git nodejs \
  && gem install --user-install bundler \
  && bundle install \
  && apk del build-dependencies \
  && mkdir /app

ADD start_container.sh /start_container.sh
RUN chmod 755 /start_container.sh
WORKDIR /

CMD ["/start_container.sh"]
