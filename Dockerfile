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


ENV APP_PATH /kart
WORKDIR ${APP_PATH}

COPY Gemfile* ./

RUN gem install bundler
RUN bundle install

COPY . ./

EXPOSE 3000
CMD [ "rails", "s" ]