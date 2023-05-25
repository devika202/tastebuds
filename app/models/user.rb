class User < ApplicationRecord
  has_one :cart
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def create_cart
    Cart.create(user: self)
  end

  def admin?
    admin
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :registerable, :recoverable, :rememberable, :validatable

  validates :firstname,
            presence: true,
            length: { minimum: 3, maximum: 10 }
  validates :phone,
            presence: { message: 'Enter a valid number!' },
            numericality: { only_integer: true },
            length: { minimum: 10, maximum: 15 }
  validates :address,
            presence: true,
            length: { minimum: 10, maximum: 200 }
  validates :lastname,
            presence: true,
            length: { minimum: 1, maximum: 10 }
  validates :username,
            presence: true,
            length: { minimum: 3, maximum: 10 }
end
