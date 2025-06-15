#!/usr/bin/env bash
# exit on error
set -o errexit

# Install PostgreSQL client and wkhtmltopdf
apt-get update -qq && apt-get install -y libpq-dev postgresql-client wkhtmltopdf

# Set library path for PostgreSQL
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean

# Skip database migration for now to avoid pg gem loading issue
# bundle exec rake db:migrate