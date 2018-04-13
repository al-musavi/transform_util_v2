require 'test_helper'

class DestFieldsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get dest_fields_new_url
    assert_response :success
  end

  test "should get create" do
    get dest_fields_create_url
    assert_response :success
  end

  test "should get update" do
    get dest_fields_update_url
    assert_response :success
  end

  test "should get edit" do
    get dest_fields_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get dest_fields_destroy_url
    assert_response :success
  end

  test "should get index" do
    get dest_fields_index_url
    assert_response :success
  end

  test "should get show" do
    get dest_fields_show_url
    assert_response :success
  end

end
