require 'test_helper'

class ProceduresControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_vet
    @procedure = FactoryBot.create(:procedure)
    # @procedure_cost = FactoryBot.create(:procedure_cost, procedure: @procedure)
  end

  test "should get index" do
    get procedures_path
    assert_response :success
  end

  test "should get new" do
    get new_procedure_path
    assert_response :success
  end

  test "should create procedure" do
    assert_difference('Procedure.count') do
      post procedures_path, params: { procedure: { name: "Prime Checkup", description: @procedure.description, length_of_time: @procedure.length_of_time, active: true } }
    end

    assert_redirected_to procedure_path(Procedure.last)

    post procedures_path, params: { procedure: { name: nil, description: @procedure.description, length_of_time: @procedure.length_of_time, active: true } }
  end

  test "should show procedure" do
    get procedure_path(@procedure)
    assert_response :success
  end

  test "should get edit" do
    get edit_procedure_path(@procedure)
    assert_response :success
  end

  test "should update procedure" do
    patch procedure_path(@procedure), params: { procedure: { name: "Prime Checkup", description: @procedure.description, length_of_time: @procedure.length_of_time, active: true } }
    assert_redirected_to procedure_path(@procedure)

    patch procedure_path(@procedure), params: { procedure: { name: nil, description: @procedure.description, length_of_time: @procedure.length_of_time, active: true } }
  end

  test "should destroy procedure" do
    assert_difference('Procedure.count', -1) do
      delete procedure_path(@procedure)
    end

    assert_redirected_to procedures_path
  end
  
  test "should not destroy procedure" do
    # have to create a treatment for the procedure so not destroyed
    @cat        = FactoryBot.create(:animal)
    @alex_user  = FactoryBot.create(:user, first_name: "Alex", last_name: "Heimann", username: "alex", role: "owner")
    @alex       = FactoryBot.create(:owner, user: @alex_user)
    @dusty      = FactoryBot.create(:pet, animal: @cat, owner: @alex, female: false)
    @visit1     = FactoryBot.create(:visit, pet: @dusty)
    @visit1_t1  = FactoryBot.create(:treatment, visit: @visit1, procedure: @procedure)
    
    assert_difference('Procedure.count', 0) do
      delete procedure_path(@procedure)
    end
  end
end


