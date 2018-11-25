class VisitsHelperTest < ActionView::TestCase
  setup do
    @animal = FactoryBot.create(:animal)
    @owner  = FactoryBot.create(:owner)
    @pet    = FactoryBot.create(:pet, owner: @owner, animal: @animal)
    @visit  = FactoryBot.create(:visit, pet: @pet)
  end

  test "should get correct pet options array for dropdown menu" do
    assert_equal [["#{@pet.name} (#{@pet.animal.name}) : #{@owner.name}", @pet.id]], get_pet_options
  end
end
