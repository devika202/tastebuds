class User < ApplicationRecord
  has_one :cart
  has_many :orders

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
                  length: {minimum: 3, maximum:100}
  validates :phone,  
                  :presence => {:message => 'Enter a valid number!'},
                  :numericality => true,
                  :length => { :minimum => 10, :maximum => 15 }
  validates :address, 
                  presence: true, 
                  length: {minimum: 10, maximum:200}
  validates :lastname, 
                  presence: true, 
                  length: {minimum: 1, maximum:100}
  validates :username, 
                  presence: true, 
                  length: {minimum: 3, maximum:100}
 
end
