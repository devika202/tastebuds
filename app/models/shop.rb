class Shop < ApplicationRecord
    has_secure_password
    has_many :sales_reports
  end
  