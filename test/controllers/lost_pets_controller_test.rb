require "test_helper"

class LostPetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lost_pets_index_url
    assert_response :success
  end

  test "should get show" do
    get lost_pets_show_url
    assert_response :success
  end

  test "should get new" do
    get lost_pets_new_url
    assert_response :success
  end

  test "should get create" do
    get lost_pets_create_url
    assert_response :success
  end

  test "should get edit" do
    get lost_pets_edit_url
    assert_response :success
  end

  test "should get update" do
    get lost_pets_update_url
    assert_response :success
  end

  test "should get destroy" do
    get lost_pets_destroy_url
    assert_response :success
  end
end
