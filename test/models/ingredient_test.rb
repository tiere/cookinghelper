require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  should belong_to(:recipe)
  should belong_to(:foodstuff)
  should belong_to(:unit)

  should validate_presence_of(:quantity)
  should ensure_inclusion_of(:quantity).in_range(0.1..9999)
  should_not allow_value('moikka').for(:quantity)
  should_not allow_value('threehundrer12').for(:quantity)
  should allow_value('100').for(:quantity)
end
