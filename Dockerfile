# syntax=docker/dockerfile:1
FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y postgresql-client vim
WORKDIR /hayate
COPY Gemfile /hayate/Gemfile
COPY Gemfile.lock /hayate/Gemfile.lock
RUN bundle install

RUN export EDITOR=vim

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
