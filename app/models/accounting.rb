class Accounting < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :sales_report, optional: true
  attr_accessor :identifier

  validate :only_one_reference_present

  private

  def only_one_reference_present
    if order_id.present? && sales_report_id.present?
      errors.add(:base, "Only one reference (Order or Sales Report) can be present")
    elsif order_id.blank? && sales_report_id.blank?
      errors.add(:base, "At least one reference (Order or Sales Report) must be present")
    end
  end
end
