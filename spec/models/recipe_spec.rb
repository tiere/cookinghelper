require 'rails_helper'

describe Recipe do
  let(:recipe) { FactoryGirl.create(:recipe) }

  it { should respond_to :name }
  it { should respond_to :ingredients }
  it { should respond_to :steps }
  it { should respond_to :category }
  it { should respond_to :user }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2).is_at_most(60) }
  it { should allow_value('The extravagant soup of best').for(:name) }
  it { should_not allow_value('Not a #$% good name').for(:name) }

  it { should validate_presence_of(:ingredients) }
  it { should validate_presence_of(:steps) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:user) }

  it { should have_many(:steps).dependent(:destroy) }
  it { should have_many(:ingredients).dependent(:destroy) }
  it { should have_many(:foodstuffs).through(:ingredients) }
  it { should belong_to(:category) }
  it { should belong_to(:user) }

  it { should accept_nested_attributes_for(:steps).allow_destroy(true) }
  it { should accept_nested_attributes_for(:ingredients).allow_destroy(true) }

  describe 'duration_to_s' do
    it 'should return sum of steps in seconds' do
      expect(recipe.duration_to_s).to eq recipe.steps.to_a.sum(&:duration)
    end
  end

  describe 'duration_to_m' do
    it 'should return sum of steps in minutes' do
      expect(recipe.duration_to_m).to eq recipe.steps.to_a.sum(&:duration) / 60
    end
  end

  describe 'progress bar' do
    describe 'when duration is between 1 and 15 minutes' do
      let(:recipe) { FactoryGirl.create(:recipe) }

      it 'should have correct width' do
        expect(recipe.progress_bar_width).to eq 30
      end

      it 'should have correct class' do
        expect(recipe.progress_bar_class).to eq 'progress-green'
      end
    end

    describe 'when duration is between 16 and 30 minutes' do
      let(:recipe) { FactoryGirl.create(:recipe, steps_count: 2) }

      it 'should have correct width' do
        expect(recipe.progress_bar_width).to eq 50
      end

      it 'should have correct class' do
        expect(recipe.progress_bar_class).to eq 'progress-yellow'
      end
    end

    describe 'when duration is between 31 and 60 minutes' do
      let(:recipe) { FactoryGirl.create(:recipe, steps_count: 4) }

      it 'should have correct width' do
        expect(recipe.progress_bar_width).to eq 80
      end

      it 'should have correct class' do
        expect(recipe.progress_bar_class).to eq 'progress-orange'
      end
    end

    describe 'when duration is over 60 minutes' do
      let(:recipe) { FactoryGirl.create(:recipe, steps_count: 5) }

      it 'should have correct width' do
        expect(recipe.progress_bar_width).to eq 100
      end

      it 'should have correct class' do
        expect(recipe.progress_bar_class).to eq 'progress-red'
      end
    end
  end
end
