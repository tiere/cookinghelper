require 'test_helper'

class StepTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should ensure_length_of(:name).is_at_least(2).is_at_most(60)
  should_not allow_value('111').for(:name).with_message('can only contain letters')
  should_not allow_value('keitto2').for(:name).with_message('can only contain letters')
  should allow_value('The cutting of bananas').for(:name)

  should validate_presence_of(:duration).with_message('must be between 1 minute and 24 hours')
  should ensure_inclusion_of(:duration).in_range(60..86400).with_message('must be between 1 minute and 24 hours')
  should validate_numericality_of(:duration)
  should_not allow_value('diipadaapa').for(:duration)
  should_not allow_value('three').for(:duration)
  should allow_value(3600).for(:duration)

  should validate_numericality_of(:duration_h)
  should ensure_inclusion_of(:duration_h).in_range(0..24).with_message('must be between 0 and 24')
  should_not allow_value('pikajuna').for(:duration_h)
  should allow_value(12).for(:duration_h)

  should validate_numericality_of(:duration_m)
  should ensure_inclusion_of(:duration_m).in_range(0..59).with_message('must be between 0 and 59')
  should_not allow_value('kolkytminuuttia').for(:duration_m)
  should allow_value(43).for(:duration_m)

  should validate_numericality_of(:duration_s)
  should ensure_inclusion_of(:duration_s).in_range(0..59).with_message('must be between 0 and 59')
  should_not allow_value('5 sekuntia').for(:duration_s)
  should allow_value(5).for(:duration_s)

  should belong_to(:recipe)
end
