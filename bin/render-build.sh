#!/usr/bin/env bash
# exit on error
set -o errexit

# Install PostgreSQL client and wkhtmltopdf
apt-get update -qq && apt-get install -y libpq-dev postgresql-client wkhtmltopdf

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate