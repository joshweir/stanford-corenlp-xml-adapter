FROM ruby:2.3.4
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev
# for capybara-webkit
#RUN apt-get install -y libqt4-webkit libqt4-dev xvfb
RUN mkdir -p /app
WORKDIR /app
COPY . ./
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
ARG RAILS_ENV=development
ENV RAILS_ENV $RAILS_ENV
#RUN if [ "$RAILS_ENV" = "production" ] ; then echo "production env" && gem install bundler && bundle install --without development test development_scraper production_scraper ; else echo "non-production env $RAILS_ENV" && gem install bundler && bundle install --without development_scraper production_scraper ; fi
#EXPOSE 3000
#CMD ["rails", "server", "-b", "0.0.0.0"]
