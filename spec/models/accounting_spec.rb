# spec/models/accounting_spec.rb
require 'rails_helper'
RSpec.describe Accounting, type: :model do
    describe 'associations' do
      it { should belong_to(:order).optional }
      it { should belong_to(:sales_report).optional }
    end
  
    describe 'validations' do
      subject { FactoryBot.build(:accounting) }
  
      it 'is valid with either order_id or sales_report_id present' do
        expect(subject).to be_valid
      end
  
      it 'is invalid with both order_id and sales_report_id present' do
        subject.order_id = 1
        subject.sales_report_id = 2
        expect(subject).to be_invalid
        expect(subject.errors[:base]).to include('Only one reference (Order or Sales Report) can be present')
      end
  
      it 'is invalid without order_id or sales_report_id' do
        subject.order_id = nil
        subject.sales_report_id = nil
        expect(subject).to be_invalid
        expect(subject.errors[:base]).to include('At least one reference (Order or Sales Report) must be present')
      end
  
      it 'is valid with only order_id present' do
        subject.order_id = 1
        subject.sales_report_id = nil
        expect(subject).to be_valid
      end
  
      it 'is valid with only sales_report_id present' do
        subject.order_id = nil
        subject.sales_report_id = 2
        expect(subject).to be_valid
      end
    end
  end
  
