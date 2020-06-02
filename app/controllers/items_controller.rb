class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images)
  end

  def new
    
  end

  def create
    
  end

  def show

  end

  private
   def item_params
    params.require(:product).permit(:name, :price, images_attributes: [:url])
   end 
end
