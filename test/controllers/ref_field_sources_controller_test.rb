require 'test_helper'

class RefFieldSourcesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ref_field_sources_new_url
    assert_response :success
  end

  test "should get create" do
    get ref_field_sources_create_url
    assert_response :success
  end

  test "should get update" do
    get ref_field_sources_update_url
    assert_response :success
  end

  test "should get edit" do
    get ref_field_sources_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get ref_field_sources_destroy_url
    assert_response :success
  end

  test "should get index" do
    get ref_field_sources_index_url
    assert_response :success
  end

  test "should get show" do
    get ref_field_sources_show_url
    assert_response :success
  end

end
