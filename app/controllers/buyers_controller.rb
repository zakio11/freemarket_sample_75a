class BuyersController < ApplicationController
  require 'payjp'
  before_action :set_card
  before_action :set_item, except: [:index]


  def index
    @item = Item.find(params[:item_id])
    if @card.blank?
      redirect_to new_card_path
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id) 
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
    Payjp::Charge.create(
      :amount => @item.price, #支払金額を引っ張ってくる
      :customer => @card.customer_id,  #顧客ID
      :currency => 'jpy',
    )
    redirect_to done_item_buyers_path
  end

  def done
  end

  private

  def set_card
    @card = Cards.find_by(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end