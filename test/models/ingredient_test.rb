require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  should belong_to(:recipe)
  should belong_to(:foodstuff)

  should validate_presence_of(:quantity)
end
