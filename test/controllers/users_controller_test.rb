require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get show_borrower" do
    get users_show_borrower_url
    assert_response :success
  end

  test "should get show_lender" do
    get users_show_lender_url
    assert_response :success
  end

  test "should get register" do
    get users_register_url
    assert_response :success
  end

end
