require 'spec_helper'

describe 'Recipe Pages' do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before do
    # Need to create one recipe so that database is populated with at least one
    # category etc.
    FactoryGirl.create(:recipe)
    sign_in user
  end

  describe 'recipe creation' do
    before { visit new_recipe_path }

    describe 'with invalid information' do
      it 'should not create a recipe' do
        expect { click_button 'Create Recipe' }.not_to change(Recipe, :count)
      end

      describe 'error messages' do
        before { click_button 'Create Recipe' }
        it { should have_field_error }
      end
    end

    describe 'with valid information' do
      before { fill_recipe_info }
      it 'should create a recipe' do
        expect { click_button 'Create Recipe' }.to change(Recipe, :count).by(1)
      end
    end
  end

  describe 'recipe index' do
    before { visit recipes_path }

    describe 'pagination' do
      before(:all) { 30.times { FactoryGirl.create(:recipe) } }
      after(:all) { Recipe.delete_all }

      it { should have_pagination_selector }

      it 'should list each recipe' do
        Recipe.paginate(page: 1).each do |recipe|
          expect(page).to have_selector('a', text: recipe.name)
        end
      end
    end
  end

  describe 'recipe show page' do
    describe 'when owner of the recipe' do
      let(:user) { FactoryGirl.create(:user) }
      let(:recipe) { FactoryGirl.create(:recipe, user: user) }

      before do
        sign_in(user)
        visit recipe_path(recipe)
      end

      it { should have_link('Delete recipe', href: recipe_path(recipe)) }

      describe 'recipe deletion' do
        it 'should destroy the recipe' do
          expect { click_link 'Delete recipe' }.to change(Recipe, :count).by(-1)
        end

        describe 'redirection' do
          before { click_link 'Delete recipe' }
          it 'should redirect to root with correct flash' do
            expect(page).to have_title('Home')
            expect(page).to have_success_message
          end
        end
      end
    end

    describe 'when not the owner of the recipe' do
      let(:different_user) { FactoryGirl.create(:user) }
      let(:recipe) { FactoryGirl.create(:recipe, user: different_user) }
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in(user)
        visit recipe_path(recipe)
      end

      it { should_not have_link('Delete recipe') }
    end
  end
end
