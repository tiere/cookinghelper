require 'test_helper'

class StepTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should ensure_length_of(:name).is_at_least(2).is_at_most(60)
  should_not allow_value('111').for(:name).with_message('can only contain letters')
  should_not allow_value('keitto2').for(:name).with_message('can only contain letters')
  should allow_value('The cutting of bananas').for(:name)

  should validate_presence_of(:duration)
  should ensure_inclusion_of(:duration).in_range(60..86400).with_message('must be between 60 and 86400')
  should validate_numericality_of(:duration)
  should_not allow_value('diipadaapa').for(:duration)
  should_not allow_value('three').for(:duration)
  should allow_value(3600).for(:duration)

  should belong_to(:recipe)
end
