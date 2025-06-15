#!/usr/bin/env bash
# exit on error
set -o errexit

# Install wkhtmltopdf
apt-get update -qq && apt-get install -y wkhtmltopdf

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
EOF

# 実行権限を付与
chmod a+x bin/render-build.sh