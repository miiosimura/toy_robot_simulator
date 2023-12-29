FROM ruby:3.0.6-bullseye as base
RUN apt-get update -qq && apt-get install -y git nodejs postgresql-client
WORKDIR /toy_robot_simulator
COPY Gemfile /toy_robot_simulator/Gemfile
COPY Gemfile.lock /toy_robot_simulator/Gemfile.lock
COPY . .
RUN bundle install

EXPOSE 3000

# Configure the main process to run when running the image

CMD [ "bundle","exec", "puma", "config.ru"]
