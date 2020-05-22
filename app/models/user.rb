class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many : items,dependent:delete_all
  # has_one : profile, dependent: :delete
  # has_one : credit_card, dependent: :delete

  # validates :email, presence: true, uniqueness: true
  # (上記バリデーションchat-spaceのコピペ)

end
