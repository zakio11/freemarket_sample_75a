class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    if user_signend_in?
    @item = Item.new
    @item.image.new
    else
      redirect_to new_user_session_path
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
  def item_params
    params.require(:item).permit(:name)
  end
end
