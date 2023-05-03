FROM ruby:3.1

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

CMD ["bin/rails", "assets:precompile", "&&", "bin/rails", "server", "-b", "0.0.0.0"]
