class CardsController < ApplicationController

  require "payjp"

  def new
     card = Card.where(user_id: current_user.id)
     redirect_to root_path if card.exists?
  end

  def pay
    Payjp.api_key = Rails.application.credentials["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to root_path
      else
        redirect_to new_card_path
      end
    end
  end

  def delete
    cards = Cards.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(cards.customer_id)
      customer.delete
      cards.delete
    end
      redirect_to action: "new"
  end


  def show
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(cards.customer_id)
      @default_cards_information = customer.cards.retrieve(cards.cards_id)
    end
  end
end
