require 'test_helper'

class ComparesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get compares_new_url
    assert_response :success
  end

  test "should get create" do
    get compares_create_url
    assert_response :success
  end

  test "should get update" do
    get compares_update_url
    assert_response :success
  end

  test "should get edit" do
    get compares_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get compares_destroy_url
    assert_response :success
  end

  test "should get index" do
    get compares_index_url
    assert_response :success
  end

  test "should get show" do
    get compares_show_url
    assert_response :success
  end

end
