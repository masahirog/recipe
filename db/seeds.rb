if Rails.env.production?
  # 本番環境ではproduction_seeds.rbを読み込む
  seeds_file = Rails.root.join('db', 'production_seeds.rb')
  
  if File.exist?(seeds_file)
    puts "Loading production seeds..."
    load seeds_file
    puts "Production seeds loaded successfully!"
  else
    puts "production_seeds.rb not found"
  end
else
  # 開発環境用のseed（必要に応じて）
  puts "Development environment - skipping production seeds"
end