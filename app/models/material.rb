class Material < ApplicationRecord
  has_many :menu_materials, dependent: :destroy
  enum category: {food:1,packed:2,other:3}


  def raw_materials_display
    material_raw_materials.includes(:raw_material).order(:position).map do |mrm|
      mrm.raw_material.display_name
    end.join('、')
  end
end
