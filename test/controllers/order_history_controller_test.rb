require 'test_helper'

class OrderHistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get order_history_index_url
    assert_response :success
  end

end
