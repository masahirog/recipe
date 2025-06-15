class CreateMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :materials do |t|
      t.integer :vendor_id
      t.string :name, null: false
      t.integer :category, null: false
      t.string :recipe_unit, null: false
      t.float :recipe_unit_price, null: false, default: 0
      t.text :memo
      t.boolean :unused_flag, null: false, default: false
      t.timestamps
      t.float :recipe_unit_gram_quantity
    end
  end
end
