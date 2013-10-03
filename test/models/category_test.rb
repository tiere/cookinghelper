require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should ensure_length_of(:name).is_at_least(2).is_at_most(60)
  should_not allow_value('111').for(:name).with_message('can only contain letters')
  should_not allow_value('soup6').for(:name).with_message('can only contain letters')
  should allow_value('Starters').for(:name)

  should have_many(:recipes)
end
