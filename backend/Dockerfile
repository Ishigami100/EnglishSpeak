FROM ruby:3.1
#Rubyのバージョンを3.1で指定

ARG RUBYGEMS_VERSION=3.4.6

WORKDIR /app

COPY ./backend/Gemfile /app/Gemfile
COPY ./backend/Gemfile.lock /app/Gemfile.lock

RUN gem update --system ${RUBYGEMS_VERSION} && \
    bundle install

COPY ./backend/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
#CMD ["rails", "server", "-b", "0.0.0.0"]

# Start the main process.
CMD ["sh", "./start-server.sh"]