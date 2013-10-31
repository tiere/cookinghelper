require 'spec_helper'

describe Recipe do

  before { @recipe = FactoryGirl.create(:recipe) }

  subject { @recipe }

  it { should respond_to :name }
  it { should respond_to :ingredients }
  it { should respond_to :steps }
  it { should respond_to :category }
  it { should respond_to :user }

  it { should be_valid }

  describe "when user_id is not preset" do
    before { @recipe.user_id = nil }
    it { should_not be_valid }
  end
end
