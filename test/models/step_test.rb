require 'test_helper'

class StepTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should ensure_length_of(:name).is_at_least(2).is_at_most(30)
  should validate_uniqueness_of(:name)
  should_not allow_value('111').for(:name)
  should_not allow_value('keitto2').for(:name)
  should allow_value('Banaanien pilkkominen').for(:name)
end
