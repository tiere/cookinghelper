require 'spec_helper'

describe Recipe do
  let(:recipe) { FactoryGirl.create(:recipe) }

  it { should respond_to :name }
  it { should respond_to :ingredients }
  it { should respond_to :steps }
  it { should respond_to :category }
  it { should respond_to :user }

  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_least(2).is_at_most(60) }
  it { should allow_value('The extravagant soup of best').for(:name) }

  it { should have_many(:steps) }
  it { should have_many(:ingredients) }
  it { should have_many(:foodstuffs).through(:ingredients) }
  it { should belong_to(:category) }

  it { should validate_presence_of(:ingredients) }
  it { should validate_presence_of(:steps) }
  it { should validate_presence_of(:category) }

  describe "duration_to_s" do
    it "should return sum of steps in seconds" do
      expect(recipe.duration_to_s).to eq recipe.steps.to_a.sum(&:duration)
    end
  end

  describe "duration_to_m" do
    it "should return sum of steps in minutes" do
      expect(recipe.duration_to_m).to eq recipe.steps.to_a.sum(&:duration) / 60
    end
  end

  describe "progress_bar_width" do
    describe "when duration is between 1 and 15 minutes" do
      let(:recipe) { FactoryGirl.create(:recipe) }
      it "should return correct value" do
        expect(recipe.progress_bar_width).to eq 30
      end
    end

    describe "when duration is between 16 and 30 minutes" do
      let(:recipe) { FactoryGirl.create(:recipe, steps_count: 2 ) }
      it "should return correct value" do
        expect(recipe.progress_bar_width).to eq 50
      end
    end

    describe "when duration is between 31 and 60 minutes" do
      let(:recipe) { FactoryGirl.create(:recipe, steps_count: 4 ) }
      it "should return correct value" do
        expect(recipe.progress_bar_width).to eq 80
      end
    end

    describe "when duration is over 60 minutes" do
      let(:recipe) { FactoryGirl.create(:recipe, steps_count: 5 ) }
      it "should return correct value" do
        expect(recipe.progress_bar_width).to eq 100
      end
    end
  end
end