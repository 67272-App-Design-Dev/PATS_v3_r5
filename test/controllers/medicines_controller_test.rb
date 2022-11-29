require 'test_helper'

class MedicinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_vet
    @medicine = FactoryBot.create(:medicine)
    # @medicine_cost = FactoryBot.create(:medicine_cost, medicine: @medicine)
  end

  test "should get index" do
    get medicines_path
    assert_response :success
  end

  test "should get new" do
    get new_medicine_path
    assert_response :success
  end

  test "should create medicine" do
    assert_difference('Medicine.count') do
      post medicines_path, params: { medicine: { name: "Improved Rabies", description: @medicine.description, stock_amount: @medicine.stock_amount, admin_method: @medicine.admin_method, unit: @medicine.unit, vaccine: @medicine.vaccine, active: true } }
    end

    assert_redirected_to medicine_path(Medicine.last)

    post medicines_path, params: { medicine: { name: nil, description: @medicine.description, stock_amount: @medicine.stock_amount, admin_method: @medicine.admin_method, unit: @medicine.unit, vaccine: @medicine.vaccine, active: true } }
  end

  test "should show medicine" do
    get medicine_path(@medicine)
    assert_response :success
  end

  test "should get edit" do
    get edit_medicine_path(@medicine)
    assert_response :success
  end

  test "should update medicine" do
    patch medicine_path(@medicine), params: { medicine: { name: @medicine.name, description: @medicine.description, stock_amount: 42, admin_method: @medicine.admin_method, unit: @medicine.unit, vaccine: @medicine.vaccine, active: true } }
    assert_redirected_to medicine_path(@medicine)

    patch medicine_path(@medicine), params: { medicine: { name: nil, description: @medicine.description, stock_amount: @medicine.stock_amount, admin_method: @medicine.admin_method, unit: @medicine.unit, vaccine: @medicine.vaccine, active: true } }
  end

  test "should destroy medicine" do
    assert_difference('Medicine.count', -1) do
      delete medicine_path(@medicine)
    end
    assert_redirected_to medicines_path
  end
  
  test "should not destroy medicine" do
    # have to create a dosage for the medicine so not destroyed
    @cat        = FactoryBot.create(:animal)
    @cat_rabies = FactoryBot.create(:animal_medicine, animal: @cat, medicine: @medicine)
    @alex_user  = FactoryBot.create(:user, first_name: "Alex", last_name: "Heimann", username: "alex", role: "owner")
    @alex       = FactoryBot.create(:owner, user: @alex_user)
    @dusty      = FactoryBot.create(:pet, animal: @cat, owner: @alex, female: false)
    @visit1     = FactoryBot.create(:visit, pet: @dusty)
    @visit1_d1  = FactoryBot.create(:dosage, visit: @visit1, medicine: @medicine)
    
    assert_difference('Medicine.count', 0) do
      delete medicine_path(@medicine)
    end
  end
end


