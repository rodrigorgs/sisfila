FROM ruby:2.7.2

# # throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle update --bundler && bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN apt-get update
RUN apt-get install -y nodejs
RUN bundle update --bundler
RUN bundle install

