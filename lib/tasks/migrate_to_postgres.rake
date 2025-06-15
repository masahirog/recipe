# lib/tasks/migrate_to_postgres.rake

namespace :db do
  desc "Export data to seed file for PostgreSQL"
  task export_seeds: :environment do
    # データをseedファイルにエクスポート
    File.open(Rails.root.join('db/production_seeds.rb'), 'w') do |f|
      f.puts "# Production seeds exported from MySQL"
      f.puts "# Generated at: #{Time.now}"
      f.puts ""
      
      # Materials
      f.puts "# Materials"
      Material.all.each do |m|
        attrs = m.attributes.except('id', 'created_at', 'updated_at')
        f.puts "Material.create!(#{attrs.inspect})"
      end
      f.puts ""
      
      # Menus
      f.puts "# Menus"
      Menu.all.each do |m|
        attrs = m.attributes.except('id', 'created_at', 'updated_at')
        f.puts "Menu.create!(#{attrs.inspect})"
      end
      f.puts ""
      
      # Products
      f.puts "# Products"
      Product.all.each do |p|
        attrs = p.attributes.except('id', 'created_at', 'updated_at')
        f.puts "Product.create!(#{attrs.inspect})"
      end
      f.puts ""
      
      # Menu Materials (IDを保持)
      f.puts "# Menu Materials"
      MenuMaterial.all.each do |mm|
        f.puts "MenuMaterial.create!(menu_id: #{mm.menu_id}, material_id: #{mm.material_id}, " +
               "amount_used: #{mm.amount_used}, preparation: #{mm.preparation.inspect}, " +
               "row_order: #{mm.row_order}, gram_quantity: #{mm.gram_quantity}, " +
               "calorie: #{mm.calorie}, protein: #{mm.protein}, lipid: #{mm.lipid}, " +
               "carbohydrate: #{mm.carbohydrate}, salt: #{mm.salt}, " +
               "source_group: #{mm.source_group.inspect}, cost_price: #{mm.cost_price})"
      end
      f.puts ""
      
      # Product Menus
      f.puts "# Product Menus"
      ProductMenu.all.each do |pm|
        f.puts "ProductMenu.create!(product_id: #{pm.product_id}, menu_id: #{pm.menu_id}, row_order: #{pm.row_order})"
      end
    end
    
    puts "Seeds exported to db/production_seeds.rb"
    puts "Total records:"
    puts "  Materials: #{Material.count}"
    puts "  Menus: #{Menu.count}"
    puts "  Products: #{Product.count}"
    puts "  Menu Materials: #{MenuMaterial.count}"
    puts "  Product Menus: #{ProductMenu.count}"
  end
end