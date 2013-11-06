require 'spec_helper'

describe "Recipe Pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before do
    # Need to create one recipe so that database is populated with at least one
    # category etc.
    FactoryGirl.create(:recipe)
    sign_in user
  end

  describe "recipe creation" do
    before { visit new_recipe_path }

    describe "with invalid information" do
      it "should not create a recipe" do
        expect { click_button "Create Recipe" }.not_to change(Recipe, :count)
      end

      describe "error messages" do
        before { click_button "Create Recipe" }
        it { should have_field_error }
      end
    end

    describe "with valid information" do
      before { fill_recipe_info }
      it "should create a recipe" do
        expect { click_button "Create Recipe" }.to change(Recipe, :count).by(1)
      end
    end
  end
end