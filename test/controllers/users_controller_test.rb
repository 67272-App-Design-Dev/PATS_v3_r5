require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_vet
    @user  = FactoryBot.create(:user)
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_path, params: { user: { first_name: "Eric", last_name: "Gruberman", username: "eric", role: "owner", password: "secret", password_confirmation: "secret", active: true } }
    end

    assert_redirected_to users_path
  
    post users_path, params: { user: { first_name: "Eric", last_name: "Gruberman", username: nil, role: "owner", password: "secret", password_confirmation: "secret", active: true } }
    assert_template :new
  end

  test "should get edit" do
    get edit_user_path(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_path(@user), params: { user: {first_name: "Eric", last_name: "Gruberman", username: @user.username, role: @user.role, password: "notsecret", password_confirmation: "notsecret", active: true } }
    assert_redirected_to users_path

    patch user_path(@user), params: { user: { first_name: "Eric", last_name: "Gruberman", username: nil, role: @user.role, password: "notsecret", password_confirmation: "notsecret", active: true } }
    assert_template :edit
  end

  test "should not destroy user" do
    assert_difference('User.count', -1) do
      delete user_path(@user)
    end

    assert_redirected_to users_path
  end
end
