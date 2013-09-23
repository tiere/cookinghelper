require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  def setup
    @ingredient = ingredients(:tomato)
  end
  test "should save with proper values" do
    assert @ingredient.valid?, "Ingredient is not valid"
    assert @ingredient.save, "Ingredient was not saved"
  end

  test "should not save without a name" do
    @ingredient.name = nil

    refute @ingredient.valid?, "Ingredient is valid"
    refute @ingredient.save, "Ingredient was saved"
  end

  test "should not save with a too short name" do
    @ingredient.name = 'a'

    refute @ingredient.valid?, "Ingredient is valid"
    refute @ingredient.save, "Ingredient was saved"
  end

  test "should not save with too long name" do
    @ingredient.name = 'b'*31

    refute @ingredient.valid?, "Ingredient is valid"
    refute @ingredient.save, "Ingredient was saved"
  end
end
