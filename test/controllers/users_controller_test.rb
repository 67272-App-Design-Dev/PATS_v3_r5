require "test_helper"

describe UsersController do
  setup do
    login_vet
    @user = FactoryBot.create(:user)
  end

  it "should get index" do
    get users_path
    value(response).must_be :success?
  end

  it "should get new" do
    get new_user_path
    value(response).must_be :success?
  end

  it "should get edit" do
    get edit_user_path(@user)
    value(response).must_be :success?
  end

end
