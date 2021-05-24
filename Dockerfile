FROM ruby:2.6.5-alpine

ENV BUNDLER_VERSION=2.2.15

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      postgresql-dev \
      python \
      tzdata \
      yarn

RUN gem install bundler -v 2.2.15

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle install

COPY . ./

EXPOSE 3000
EXPOSE 5432

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]