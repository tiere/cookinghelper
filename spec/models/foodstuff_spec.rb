require 'spec_helper'

describe Foodstuff do
  it { should respond_to :name }
  it { should respond_to :ingredients }

  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_least(2).is_at_most(30) }
  it { should validate_uniqueness_of(:name) }
  it { should allow_value('Salt').for(:name) }
  it { should_not allow_value('S?alt').for(:name) }

  it { should have_many(:ingredients) }
  it { should have_many(:recipes).through(:ingredients) }
end