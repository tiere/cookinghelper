require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)
  should ensure_length_of(:name).is_at_least(2).is_at_most(60)
  should_not allow_value('111').for(:name)
  should_not allow_value('kilograms3').for(:name)
  should allow_value('Kilograms').for(:name)

  should validate_presence_of(:abbreviation)
  should validate_uniqueness_of(:abbreviation)
  should ensure_length_of(:abbreviation).is_at_least(1).is_at_most(10)
  should_not allow_value('111').for(:abbreviation)
  should_not allow_value('ltr7').for(:abbreviation)
  should allow_value('kg').for(:abbreviation)

  should have_many(:ingredients)
end
