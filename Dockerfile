FROM ruby:3.1.4

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get update -qq \
    && apt-get install -y nodejs \
    && npm install -g yarn

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends imagemagick libvips42

RUN mkdir /yokutype
WORKDIR /yokutype
COPY Gemfile /yokutype/Gemfile
COPY Gemfile.lock /yokutype/Gemfile.lock
RUN bundle install
COPY . /yokutype

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
