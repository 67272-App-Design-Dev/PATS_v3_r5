require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get home_path
    assert_response :success
  end

  test "should get about" do
    get about_path
    assert_response :success
  end

  test "should get contact" do
    get contact_path
    assert_response :success
  end

  test "should get privacy" do
    get privacy_path
    assert_response :success
  end
  
  test "should get search" do
    get search_path, params: { query: "Dusty" }
    assert_response :success
  end
  
  test "should handle blank search" do
    get search_path, params: { query: nil }
    assert_response :redirect
  end

end
