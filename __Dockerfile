FROM ubuntu:16.04

# Options
ENV RUBY_VERSION_MAJOR 2.7
ENV RUBY_VERSION 2.7.1
ENV BUNDLER_VERSION 2.0.2
ENV NODE_VERSION 8.x
ENV PHANTOMJS_VERSION 2.1.1

# Install dependencies
RUN apt-get update && apt-get -y install \
      git \
      wget \
      autoconf \
      bison \
      build-essential \
      libssl-dev \
      libyaml-dev \
      libreadline6-dev \
      zlib1g-dev \
      libncurses5-dev \
      libffi-dev \
      libpq-dev \
      libgdbm3 \
      libgdbm-dev \
      libfontconfig1 \
      libxrender1 \
      libxext6 \
      ca-certificates \
      bzip2 \
      libfontconfig \
      fontconfig \
      imagemagick \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Ruby
RUN wget -q http://ftp.ruby-lang.org/pub/ruby/$RUBY_VERSION_MAJOR/ruby-$RUBY_VERSION.tar.gz \
    && tar -xzvf ruby-$RUBY_VERSION.tar.gz \
    && cd ruby-$RUBY_VERSION \
    && ./configure \
    && make \
    && make install \
    && rm -rf ../ruby-$RUBY_VERSION*

# Install Bundler
RUN gem install bundler -v $BUNDLER_VERSION

# Install NodeJS
RUN wget -qO- https://deb.nodesource.com/setup_$NODE_VERSION | bash - \
    && apt-get install -y nodejs

# Install PhantomJS
RUN wget -q https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 \
    && tar -xjvf phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 \
    && mv phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/local/bin \
    && rm -rf phantomjs-$PHANTOMJS_VERSION-linux-x86_64*

# Install fonts
COPY .fonts/ /usr/share/fonts
RUN fc-cache -f -v

# Specify working directory
ENV APP_HOME /app
WORKDIR $APP_HOME

# Install dependencies
COPY Gemfile       ./Gemfile
COPY Gemfile.lock  ./Gemfile.lock
COPY .ruby-version ./.ruby-version
RUN bundle install -j 8 --deployment

# Copy all files
COPY . ./

# Puma is missing tmp/pids/server.pid after Rails 6 upgrade
RUN mkdir -p ./tmp/pids

# Precompile assets
ARG RAILS_ENV
ARG SEGMENT_ANALYTICS_WRITE_KEY
ARG WARDEN_SECRET_KEY
ARG WARDEN_PEPPER
ARG BACKEND_HOST
ARG NO_REPLY_EMAIL
ARG SEND_PARTNER_REPORTS_TO
ARG SEND_REPORTS_TO
ARG DEFAULT_CLAIM_EMAIL_TO
ARG SECRET_KEY_BASE
ARG TEXT_ENCRYPTION_SECRET_KEY
ARG STRIPE_SECRET_KEY
ARG STRIPE_PUBLISHABLE_KEY
ARG STRIPE_ENDPOINT_SECRET
ARG SMTP_USERNAME
ARG SMTP_PASSWORD
ARG SMTP_ADDRESS
ARG SMTP_PORT
ARG CLIENT_URL
ARG SECURE_CHANNEL_KEY
ARG INSTANCE_NAME
ARG RENEW_POLICY_EACH
ARG SIDEKIQ_REDIS_URL
ARG FEATURE_ALLOW_BYPASSES
ARG ALLOW_TEST_TASKS
ARG OFAC_API_KEY
ARG SANCTION_SEARCH_USER_ID
ARG SANCTION_SEARCH_USER_KEY
ARG OPENCORPORATES_PRIVATE_KEY
RUN if [ "$RAILS_ENV" = "production" ]; then bundle exec rake assets:precompile; else echo Skip assets compilation..; fi

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
