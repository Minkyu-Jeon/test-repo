FROM ruby:3.0.0-alpine as prebuild-stage

ARG BUNDLE_WITHOUT="development:test"
ENV BUNDLE_WITHOUT ${BUNDLEWITHOUT}
ENV BUNDLER_VERSION=2.1.2

ARG RAILS_SERVE_STATIC_FILES=true
ENV RAILS_SERVE_STATIC_FILES ${RAILS_SERVE_STATIC_FILES}

ARG RAILS_ENV=production
ENV RAILS_ENV ${RAILS_ENV}

ENV BUNDLE_PATH="/gems"

RUN apk update && \
  apk add \
  openssl \
  tar \
  build-base \
  tzdata \
  postgresql-dev \
  postgresql-client \
  git \
  && mkdir -p /var/app \
  && gem install bundler

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN if [ "$RAILS_ENV" = "production" ]; then \
  bundle config set without 'development test'; bundle install -j 4 -r 3; \
  else bundle install -j 4 -r 3; \
  fi

COPY . /app

FROM ruby:3.0.0-alpine

ARG BUNDLE_WITHOUT="development:test"
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}
ENV BUNDLER_VERSION=2.1.2

ARG EXECJS_RUNTIME="Disabled"
ENV EXECJS_RUNTIME ${EXECJS_RUNTIME}

ARG RAILS_SERVE_STATIC_FILES=true
ENV RAILS_SERVE_STATIC_FILES ${RAILS_SERVE_STATIC_FILES}

ARG RAILS_ENV=production
ENV RAILS_ENV ${RAILS_ENV}
ENV BUNDLE_PATH="/gems"

RUN apk add --update --no-cache \
  openssl \
  tzdata \
  postgresql-client \
  imagemagick \
  && gem install bundler

COPY --from=prebuild-stage /gems/ /gems/
COPY --from=prebuild-stage /app /app


RUN rm -rf /gems/ruby/3.0.0/cache/*gem \
  && find /gems/ruby/3.0.0/gems/ -name "*.c" -delete \
  && find /gems/ruby/3.0.0/gems/ -name "*.o" -delete
RUN mkdir -p /app/log

WORKDIR /app