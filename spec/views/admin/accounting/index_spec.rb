require 'rails_helper'

RSpec.describe 'admin/accounting/index', type: :view do
  let(:from_date) { Date.new(2023, 1, 1) }
  let(:to_date) { Date.new(2023, 1, 31) }
  let(:accounting_records) { [] }

  before do
    assign(:from_date, from_date)
    assign(:to_date, to_date)
    assign(:accounting_records, accounting_records)
    render
  end

  it 'displays the page title' do
    expect(rendered).to have_selector('h1', text: 'Accounting Records')
  end

  it 'renders the form' do
    expect(rendered).to have_selector('form[action="/admin/accounting"][method="GET"]') do |form|
      expect(form).to have_selector('input[type="date"][id="from_date"][name="from_date"]')
      expect(form).to have_selector('input[type="date"][id="to_date"][name="to_date"]')
      expect(form).to have_selector('button[type="submit"][class="btn btn-primary ml-2"]')
      expect(form).to have_link('Show all', href: admin_accounting_index_path, class: "btn btn-primary")
    end
  end

  it 'displays the accounting records table' do
    expect(rendered).to have_selector('table.table') do |table|
      expect(table).to have_selector('thead th', text: 'Mode of sales')
      expect(table).to have_selector('thead th', text: 'Order ID')
      expect(table).to have_selector('thead th', text: 'Sales Report ID')
      expect(table).to have_selector('thead th', text: 'Amount')
      expect(table).to have_selector('thead th', text: 'Date')
      expect(table).to have_selector('thead th', text: 'Action')
    end
  end

  it 'displays the total sales amount and count' do
    expect(rendered).to have_selector('div.text-center') do |div|
      expect(div).to have_selector('h4', text: 'Total Sales Amount:')
      expect(div).to have_selector('h4', text: 'Sales Count:')
    end
  end
end
