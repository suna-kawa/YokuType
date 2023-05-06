FROM ruby:3.1.4

RUN mkdir /yokutype
WORKDIR /yokutype
ENV LANG=C.UTF-8 \
    RAILS_ENV=production \
    RACK_ENV=production
COPY Gemfile /yokutype/Gemfile
COPY Gemfile.lock /yokutype/Gemfile.lock
RUN bundle install
COPY . /yokutype

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
# RUN rails assets:precompile
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
