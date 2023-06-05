require 'rails_helper'

RSpec.describe Admin::AccountingController, type: :controller do
  describe 'GET #index' do
    it 'assigns all accounting records, orders, and sales reports' do
      orders = create_list(:order, 3)
      sales_reports = create_list(:sales_report, 3)
      accounting_records = [
        create(:accounting, sales_report_id: sales_reports[0].id),
      ]
  
      get :index
    end

    context 'with from_date parameter' do
      it 'filters accounting records by from_date' do
        accounting_record = create(:accounting, created_at: 2.days.ago, sales_report: create(:sales_report))
        from_date = 3.days.ago.to_date

        get :index, params: { from_date: from_date }
      end
    end

    context 'with to_date parameter' do
      it 'filters accounting records by to_date' do
        accounting_record = create(:accounting, created_at: 2.days.ago, sales_report: create(:sales_report))
        to_date = 1.day.ago.to_date

        get :index, params: { to_date: to_date }
      end
    end
  end
  
  describe 'GET #new' do
    it 'assigns a new accounting record, orders, and sales reports' do
      get :new
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new accounting record' do
        accounting_params = { accounting: attributes_for(:accounting) }

        expect {
          post :create, params: accounting_params
        }
      end

      it 'redirects to the index page' do
        accounting_params = { accounting: attributes_for(:accounting) }

        post :create, params: accounting_params

      end

      it 'sets a success flash message' do
        accounting_params = { accounting: attributes_for(:accounting) }

        post :create, params: accounting_params

      end
    end

    context 'with invalid parameters' do
        it 'does not create a new accounting record' do
            accounting_params = { accounting: attributes_for(:accounting, :invalid) }
        
            expect {
            post :create, params: accounting_params
            }.not_to change(Accounting, :count)
        end

      it 'renders the new template' do
        accounting_params = { accounting: attributes_for(:accounting, :invalid) }

        post :create, params: accounting_params
      end

      it 'sets an error flash message' do
        accounting_params = { accounting: attributes_for(:accounting, :invalid) }

        post :create, params: accounting_params
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the accounting record' do
      sales_report = create(:sales_report)
      accounting_record = create(:accounting, sales_report: sales_report)
  
      expect {
        delete :destroy, params: { id: accounting_record.id }
      }
    end

    it 'redirects to the index page' do
      sales_report = create(:sales_report)
      accounting_record = create(:accounting, sales_report: sales_report)
      delete :destroy, params: { id: accounting_record.id }
    end

    it 'sets a notice flash message' do
      sales_report = create(:sales_report)
      accounting_record = create(:accounting, sales_report: sales_report)
      delete :destroy, params: { id: accounting_record.id }
    end
  end
end
