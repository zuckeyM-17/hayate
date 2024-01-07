# syntax=docker/dockerfile:1
FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim
WORKDIR /hayate
COPY Gemfile /hayate/Gemfile
COPY Gemfile.lock /hayate/Gemfile.lock
RUN bundle install
RUN rails tailwindcss:install

RUN export EDITOR=vim

# コンテナー起動時に毎回実行されるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
