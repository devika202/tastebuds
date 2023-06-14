class Shop < ApplicationRecord
    has_secure_password
    has_many :sales_reports
    validates :name, presence: true, length: {minimum: 6, maximum: 30}
    validates :location, presence: true, length: {minimum: 6, maximum: 300}
    validates :contact_info, presence: true, length: {minimum: 6, maximum: 300}
    validates :email, 
              uniqueness:{ case_sensitive: false}, 
              presence: true
    validates :email, 
        format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, 
        presence: true
    validates :password_confirmation, 
        presence: true
end
  