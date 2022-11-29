require 'test_helper'

class VisitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_vet
    @animal = FactoryBot.create(:animal)
    @owner  = FactoryBot.create(:owner)
    @pet    = FactoryBot.create(:pet, owner: @owner, animal: @animal)
    @visit  = FactoryBot.create(:visit, pet: @pet)
  end

  test "should get index for vet" do
    get visits_path
    assert_response :success
  end
  
  test "should get index for owner" do
    login_owner
    get visits_path
    assert_response :success
  end

  test "should get new" do
    get new_visit_path
    assert_response :success
  end

  test "should create visit" do
    assert_difference('Visit.count') do
      post visits_path, params: { visit: { pet_id: @pet.id, date: Date.current, weight: 2.0 } }
    end

    assert_redirected_to visit_path(Visit.last)
  
    post visits_path, params: { visit: { pet_id: @pet.id, date: Date.current, weight: nil } }
  end

  test "should show visit" do
    get visit_path(@visit)
    assert_response :success
  end

  test "should get edit" do
    get edit_visit_path(@visit)
    assert_response :success
  end

  test "should update visit" do
    patch visit_path(@visit), params: { visit: { pet_id: @visit.pet.id, date: @visit.date, weight: 2.5 } }
    assert_redirected_to visit_path(@visit)

    patch visit_path(@visit), params: { visit: { pet_id: @visit.pet.id, date: @visit.date, weight: nil } }
  end

  test "should not destroy visit" do
    assert_difference('Visit.count', 0) do
      delete visit_path(@visit)
    end

    assert_redirected_to visit_path(@visit)
  end
  
  test "should get dosages" do
    ## only used for json/vuejs; for now just an empty array
    get("#{visit_dosages_path(@visit)}.json")
    assert_response :success
    assert_equal @response.body, "[]"
  end
end
