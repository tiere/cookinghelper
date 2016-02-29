require 'rails_helper'

describe Category do
  it { should respond_to :name }
  it { should respond_to :recipes }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2).is_at_most(60) }
  it { should allow_value('Starters').for(:name) }
  it { should_not allow_value('St$rt#rs').for(:name) }

  it { should have_many(:recipes) }
end
