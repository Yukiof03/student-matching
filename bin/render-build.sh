#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# CSS build (must be done before assets:precompile)
npm install
npm run build:css

# Precompile assets
bundle exec rake assets:precompile
bundle exec rake assets:clean

# Run database migrations and seed
bundle exec rake db:migrate
bundle exec rake db:seed
