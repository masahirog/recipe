class PdfsController < ApplicationController

  def product_recipe
    @product = Product.includes(
      product_menus: { menu: { menu_materials: :material } }
    ).find(params[:product_id])
    
    @serving_size = params[:serving_size].to_i
    @serving_size = 1 if @serving_size <= 0
    
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "レシピ_#{@product.name}_#{@serving_size}人前",
               template: "pdfs/product_recipe",
               layout: "layouts/pdf",
               formats: [:html],
               disposition: 'inline',
               encoding: "UTF-8",
               page_size: "A4",
               orientation: "Portrait",
               margin: { top: 5, bottom: 10, left: 5, right: 5 }
      end
    end
  end
end