FROM jruby:9.1.17.0-onbuild

ENV RAILS_ENV=production

EXPOSE 3000/tcp

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
COPY config/database.yml.docker /usr/src/app/config/database.yml

CMD ["./run_with_init.sh"]
