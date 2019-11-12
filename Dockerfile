FROM ruby:2.6.2-alpine

RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                nodejs \
                                openssh \
                                less \
                                bash \
                                yarn \
                                tzdata


ENV APP_PATH /app
WORKDIR $APP_PATH

COPY Gemfile* ./

RUN gem install bundler
RUN bundle install

EXPOSE 3000