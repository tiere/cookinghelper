require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should ensure_length_of(:name).is_at_least(2).is_at_most(60)
  should_not allow_value('111').for(:name).with_message('can only contain letters')
  should_not allow_value('badsoup3').for(:name).with_message('can only contain letters')
  should allow_value('The extravagant soup of best').for(:name)

  should have_many(:steps)
  should have_many(:ingredients)
  should have_many(:foodstuffs).through(:ingredients)
  should belong_to(:category)

  should validate_presence_of(:ingredients)
  should validate_presence_of(:steps)
  should validate_presence_of(:category)

  test "duration should return sum of steps duations in seconds" do
    recipe = recipes(:carrotsoup)
    assert_equal recipe.duration, 645
  end

  test "progress_bar_width should return correct value" do
    recipe = recipes(:carrotsoup)
    assert_equal recipe.progress_bar_width, 80

    recipe = recipes(:fishsticks)
    assert_equal recipe.progress_bar_width, 100
  end
end
