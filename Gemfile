source "https://rubygems.org"

ruby "3.1.4"
gem "rails", "~> 7.1.2"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "slim-rails", "~> 3.7"
gem 'cocoon'
gem "select2-rails"
gem 'will_paginate'
gem 'will_paginate-bootstrap-style'
gem 'activerecord-import'
gem 'rails-i18n'
gem 'gon'
gem 'image_processing'
gem 'sassc-rails'
gem 'jquery-rails'
gem 'enum_help'
gem 'acts_as_list'
gem 'aws-sdk-s3', require: false
gem 'wicked_pdf'

group :development, :test do
  gem "mysql2", "~> 0.5"  # MySQLは開発/テスト環境のみ
  gem "debug", platforms: %i[ mri windows ]
  gem 'pry-rails'
end

group :development do
  gem "web-console"
  gem 'bullet'
  gem 'wkhtmltopdf-binary'
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

group :production do
  gem 'rails_12factor'
  gem 'pg', '~> 1.5'  # 本番環境はPostgreSQL
end