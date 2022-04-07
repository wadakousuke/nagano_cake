require "test_helper"

class Admin::CustomerssControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_customerss_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_customerss_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_customerss_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_customerss_update_url
    assert_response :success
  end
end
