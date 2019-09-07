FROM ruby:2.5.1

RUN apt-get update -qq &&  apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /time_to_answer
WORKDIR /time_to_answer

ADD Gemfile /time_to_answer/Gemfile
ADD Gemfile.lock /time_to_answer/Gemfile.lock

RUN bundle install

ADD . /time_to_answer