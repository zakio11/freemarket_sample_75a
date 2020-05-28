class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]

  def index
    @items = Item.includes(:images)
  end

  def new
    #if user_signned_in?
    @item = Item.new
    @item.images.new
    #else
      #redirect_to new_user_session_path
    #end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destory
    @item.destory
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :introdction, :price, :shipment_date, :shipment_pref, :category, :brand, :item_status, :shipment_fee, images_attributes: [:url, :_destory, :id])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
