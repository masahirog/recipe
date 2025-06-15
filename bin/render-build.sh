#!/usr/bin/env bash
# exit on error
set -o errexit

# 本番環境であることを明示
export RAILS_ENV=production
export BUNDLE_WITHOUT="development test"

# デバッグ情報を出力
echo "RAILS_ENV: $RAILS_ENV"
echo "DATABASE_URL is set: ${DATABASE_URL:+yes}"
echo "RAILS_MASTER_KEY is set: ${RAILS_MASTER_KEY:+yes}"
echo "SECRET_KEY_BASE is set: ${SECRET_KEY_BASE:+yes}"

# 依存関係をインストール
bundle install --without development test

# アセットをプリコンパイル
bundle exec rake assets:precompile
bundle exec rake assets:clean

# データベースの作成とマイグレーション
bundle exec rake db:create RAILS_ENV=production || true
bundle exec rake db:migrate RAILS_ENV=production