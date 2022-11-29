require 'test_helper'

class PetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_vet
    @animal = FactoryBot.create(:animal)
    @owner  = FactoryBot.create(:owner)
    @pet    = FactoryBot.create(:pet, owner: @owner, animal: @animal)
  end

  test "should get index for vet" do
    get pets_path
    assert_response :success
  end
  
  test "should get index for owner" do
    login_owner
    get pets_path
    assert_response :success
  end

  test "should get new" do
    get new_pet_path
    assert_response :success
  end

  test "should create pet" do
    assert_difference('Pet.count') do
      post pets_path, params: { pet: { name: "Honey", animal_id: @animal.id, owner_id: @owner.id, female: true, date_of_birth: 3.years.ago.to_date, active: true } }
    end

    assert_redirected_to pet_path(Pet.last)

    post pets_path, params: { pet: { name: nil, animal_id: @animal.id, owner_id: @owner.id, female: true, date_of_birth: 3.years.ago.to_date, active: true } }
  end

  test "should show pet" do
    get pet_path(@pet)
    assert_response :success
  end

  test "should get edit" do
    get edit_pet_path(@pet)
    assert_response :success
  end

  test "should update pet" do
    patch pet_path(@pet), params: { pet: { name: "Honey", animal_id: @pet.animal.id, owner_id: @pet.owner.id, female: true, date_of_birth: @pet.date_of_birth, active: true } }
    assert_redirected_to pet_path(@pet)

    patch pet_path(@pet), params: { pet: { name: nil, animal_id: @pet.animal.id, owner_id: @pet.owner.id, female: true, date_of_birth: @pet.date_of_birth, active: true } }
  end

  test "should not destroy pet" do
    assert @pet.active
    ## We no longer allow pets to be destroyed
    assert_difference('Pet.count', 0) do
      delete pet_path(@pet)
    end
    ## ... but they are now made inactive
    @pet.reload
    deny @pet.active
    # assert_redirected_to pets_path
  end
end
