#!/usr/bin/env bash
# exit on error
set -o errexit

# 依存関係をインストール
bundle install

# アセットをプリコンパイル
bundle exec rake assets:precompile
bundle exec rake assets:clean

# データベースの作成とマイグレーション
bundle exec rake db:create RAILS_ENV=production || true
bundle exec rake db:migrate RAILS_ENV=production