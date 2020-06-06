class CardsController < ApplicationController

  require "payjp"
  before_action :set_item, only: [:purchase, :buy]
  before_action :set_card, only: [:new, :delete, :show, :pay, :purchase, :buy]


  def new
     cards = Cards.where(user_id: current_user.id)
     redirect_to "/cards/show" if cards.exists?
  end


  def delete
    card = Cards.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
      flash[:alert] = 'カード情報を削除しました。'
    end
      redirect_to root_path
  end

  

  def show
    card = Cards.where(user_id: current_user.id).first
    if card.blank?
      redirect_to new_card_path 
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)
    end
  end


  def pay   # クレジットカード登録
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Cards.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to root_path
      else
        redirect_to new_card_path
        flash[:alert] = '登録に失敗しました。'
      end
    end
  end


  def purchase  # 購入確認画面へ遷移
    @card = Cards.where(user_id: current_user.id).first

    if @card.blank?
      redirect_to new_card_path
      flash[:alert] = 'カードが登録されていません'
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id) 
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end


  def buy #購入処理
    card = Cards.where(user_id: current_user.id).first
    if card.blank?
      flash[:alert] = '購入にはクレジットカード登録が必要です'
      redirect_to new_card_path
    else
      # card = current_user.credit_card
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      Payjp::Charge.create(
      amount: @item.price,          #支払金額
      customer: card.customer_id,   #顧客ID
      currency: 'jpy', 
      )

      if @item.update(buyer_id: current_user.id)
        redirect_to done_item_cards_path(@item.id)
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: "items", action: 'show'
      end

    end
  end


  
    private

  def set_card
    @card = Cards.find_by(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end


end
