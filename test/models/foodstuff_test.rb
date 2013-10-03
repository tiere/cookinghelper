require 'test_helper'

class FoodstuffTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should ensure_length_of(:name).is_at_least(2).is_at_most(30)
  should validate_uniqueness_of(:name)
  should_not allow_value('111').for(:name).with_message('can only contain letters')
  should_not allow_value('banaani2').for(:name).with_message('can only contain letters')
  should allow_value('salt').for(:name)

  should have_many(:ingredients)
  should have_many(:recipes).through(:ingredients)
end
