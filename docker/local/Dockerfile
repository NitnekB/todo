FROM ruby:2.6.2

RUN apt-get update && apt-get install -qqy --no-install-recommends \
    nodejs \
    postgresql-client && apt-get clean

WORKDIR /app

COPY Gemfile* /app/

RUN gem install bundler:2.0.1 && bundle install

CMD rm -f /tmp/pid && bundle exec puma -C config/puma.rb
