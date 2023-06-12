require 'rails_helper'

RSpec.describe 'admin/orders/index', type: :view do
  before(:each) do
    assign(:orders, [
      FactoryBot.create(:order, user: FactoryBot.create(:user)),
      FactoryBot.create(:order, user: FactoryBot.create(:user))
    ])
  end

  it 'displays all orders' do
    render

    assert_select 'h1', text: 'All Orders', count: 1

    assert_select 'table.table' do
      assert_select 'thead.thead-dark' do
        assert_select 'th', text: 'User', count: 1
        assert_select 'th', text: 'Total Amount', count: 1
        assert_select 'th', text: 'Status', count: 1
        assert_select 'th', text: 'Actions', count: 1
        assert_select 'th', text: 'Change Order Status', count: 1
      end

      assert_select 'tbody.table-group-divider' do
        assert_select 'tr', count: 2 do |rows|
          rows.each_with_index do |row, index|
            order = Order.all[index]

            assert_select row, 'td', text: order.user.email, count: 1
            assert_select row, 'td', text: number_to_currency(order.total_price, unit: '₹'), count: 1
            assert_select row, 'td' do
              assert_select 'a[href=?]', admin_order_path(order), text: 'View', count: 1
            end

            assert_select row, 'td' do
              if order.status == 'delivered'
                assert_select 'p', text: /Order status: #{order.status}/, count: 1
              else
                assert_select 'form[action=?][method=?]', admin_order_path(order), 'post' do
                  assert_select 'div.form-group.row.form-label.justify-content-center.align-items-center' do
                    assert_select 'select[name=?]', 'order[status]', count: 1
                    assert_select 'input[type=?][value=?]', 'submit', 'Update', count: 1
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
