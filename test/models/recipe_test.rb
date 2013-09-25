require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should ensure_length_of(:name).is_at_least(2).is_at_most(60)
  should_not allow_value('111').for(:name)
  should_not allow_value('badsoup3').for(:name)
  should allow_value('The extravagant soup of best').for(:name)


  should have_and_belong_to_many(:ingredients)
  should have_many(:steps)
end
