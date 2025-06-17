# db/seeds.rb
if Rails.env.development?
  # 開発環境用のseed
  puts "Development environment - loading development seeds"
  # 開発用のデータ
elsif Rails.env.production?
  # 本番環境では何もしない
  puts "Production environment - skipping seeds (already configured)"
else
  puts "Test environment - skipping seeds"
end