FROM ruby:2.3.7
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["rails s"]