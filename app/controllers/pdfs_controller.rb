class PdfsController < ApplicationController

  def product_recipe
    @product = Product.includes(
      product_menus: { 
        menu: { 
          menu_materials: :material 
        } 
      }
    ).find(params[:product_id])
    
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "レシピ_#{@product.name}",
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