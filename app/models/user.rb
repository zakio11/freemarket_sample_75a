class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true
  has_one :profile

  
  # 下記は単体テストで使用するため残してください 
  # FactoryBot.define do
  #   factory :user do
  #     nickname              {"ohara"}
  #     email                 {"aaa@gmail.com"}
  #     password              {"1111111"}
  #     password_confirmation {"1111111"}
  #   end
  # end

end
