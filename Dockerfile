FROM ruby:2.5.3

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends vim \
  postgresql-client \
  cron \
  nodejs

RUN apt-get install -y nodejs

RUN mkdir -p /var/www/cupom
WORKDIR /var/www/cupom
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . /var/www/cupom

CMD ["rails", "server", "-b", "0.0.0.0"]
