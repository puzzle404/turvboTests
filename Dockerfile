FROM ruby:3.1.2

RUN gem update --system
RUN gem install "bundler:~>2" --no-document && \
  gem update --system && \
  gem cleanup


RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN (curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -) && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn


WORKDIR /app
COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle config set --local without 'development test'
RUN bundle install

RUN yarn install

COPY . /app

ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV RACK_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true
# [START cloudrun_rails_dockerfile_key]
# [END cloudrun_rails_dockerfile_key]
ENV SECRET_KEY_BASE=pepe

RUN rake assets:precompile --trace

RUN bundle exec rails db:create
RUN bundle exec rails db:migrate
RUN bundle exec rails db:seed

EXPOSE 8080
CMD bundle exec rails server -b 0.0.0.0 -p 8080
