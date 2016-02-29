require 'rails_helper'

describe Ingredient do
  it { should respond_to(:quantity) }
  it { should respond_to(:foodstuff) }
  it { should respond_to(:recipe) }
  it { should respond_to(:unit) }

  it { should validate_presence_of(:quantity) }
  it do
    should validate_inclusion_of(:quantity).in_range(0.1..9999)
                                           .with_message('must be between 0.1 and 9999')
  end
  it { should_not allow_value('three').for(:quantity) }
  it { should allow_value(100).for(:quantity) }

  it { should validate_presence_of(:unit) }
  it { should validate_presence_of(:foodstuff) }

  it { should belong_to(:recipe) }
  it { should belong_to(:foodstuff) }
  it { should belong_to(:unit) }
end
