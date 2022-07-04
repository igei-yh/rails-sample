FROM ruby:2.7

WORKDIR /sample

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
RUN apt-get update -qq
COPY Gemfile /sample/Gemfile
COPY Gemfile.lock /sample/Gemfile.lock
RUN bundle install
COPY . /sample
RUN bundle exec rails webpacker:install
RUN yarn install --check-files
