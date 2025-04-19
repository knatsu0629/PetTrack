require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_update_url
    assert_response :success
  end

  test "should get deactivate" do
    get users_deactivate_url
    assert_response :success
  end

  test "should get search" do
    get users_search_url
    assert_response :success
  end

  test "should get guest_sign_in" do
    get users_guest_sign_in_url
    assert_response :success
  end
end
