class Item < ApplicationRecord
  #belongs_to :user 
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipment_pref
  belongs_to_active_hash :shipment_date
  belongs_to_active_hash :shipment_fee
  belongs_to_active_hash :item_status


  validates :name,          presence: true, length: {maximum: 40}
  validates :introduction,  presence: true, length: {maximum: 1000}
  validates :price,         presence: true
  validates :shipment_date, presence: true
  validates :shipment_pref, presence: true
  validates :category_id,   presence: true
  validates :item_status,   presence: true
  validates :shipment_fee,  presence: true
  #validates :seller,        presence: true
end