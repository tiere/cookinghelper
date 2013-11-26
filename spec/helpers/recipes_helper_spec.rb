require 'spec_helper'

describe RecipesHelper do
  describe "owner_of_recipe" do
    let!(:owner) { FactoryGirl.create(:user) }
    let!(:not_owner) { FactoryGirl.create(:user) }
    let!(:recipe) { FactoryGirl.create(:recipe, user: owner) }

    describe "when not the owner of a recipe" do
      it 'should return false' do
        allow(helper).to receive(:current_user).and_return(not_owner)
        expect(helper.owner_of_recipe(recipe)).to eq false
      end
    end

    describe "when the owner of a recipe" do
      it 'should return true' do
        allow(helper).to receive(:current_user).and_return(owner)
        expect(helper.owner_of_recipe(recipe)).to eq true
      end
    end
  end
end
