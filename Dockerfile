FROM ruby:2.6.5-alpine

ENV APP_PATH /var/app
ENV ROOT_PATH /great-test-app
ENV BUNDLE_VERSION 2.2.15
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000

# copy entrypoint scripts and grant execution permissions
COPY ./dev-entrypoint.sh /usr/local/bin/dev-entrypoint.sh
#COPY ./test-entrypoint.sh /usr/local/bin/test-entrypoint.sh
RUN chmod +x /usr/local/bin/dev-entrypoint.sh
#&& chmod +x /usr/local/bin/test-entrypoint.sh

# install dependencies for application
RUN apk -U add --no-cache \
build-base \
git \
postgresql-dev \
postgresql-client \
libxml2-dev \
libxslt-dev \
nodejs \
yarn \
imagemagick \
tzdata \
less \
&& rm -rf /var/cache/apk/* \
&& mkdir -p $APP_PATH



RUN gem install bundler --version "$BUNDLE_VERSION" \
&& rm -rf $GEM_HOME/cache/*

#COPY package.json yarn.lock ./

#RUN yarn install --check-files

CMD apt-get install nginx

ADD Gemfile $ROOT_PATH/Gemfile
ADD Gemfile.lock $ROOT_PATH/Gemfile.lock
RUN bundle install
WORKDIR $APP_PATH






EXPOSE $RAILS_PORT
EXPOSE 5432

ENTRYPOINT [ "bundle", "exec" ]