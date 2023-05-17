class Accounting < ApplicationRecord
    belongs_to :order
    belongs_to :sales_report
  end