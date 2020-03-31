FROM ruby:2.6.5-stretch

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get update && apt-get install -y build-essential libpq-dev
RUN apt-get install -y nodejs
RUN npm install -g yarn

RUN mkdir app

WORKDIR /app

COPY Gemfile.lock Gemfile package.json yarn.lock ./

RUN bundle install

ADD . /app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]