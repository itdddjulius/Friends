FROM ruby:2.7.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN gem install bundler
RUN bundler update --bundler
RUN bundle install

EXPOSE 3000
CMD ["/bin/sh", "service", "rails", "server", "-b", "0.0.0.0"]
