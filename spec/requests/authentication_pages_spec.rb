require 'spec_helper'

describe 'Authentication' do
  subject { page }

  describe 'signin page' do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign In') }
  end

  describe 'signin' do
    before { visit signin_path }

    describe 'with invalid information' do
      before { click_button 'Sign in' }

      it { should have_title('Sign In') }
      it { should have_error_message 'Invalid' }

      describe 'when visiting a new page' do
        before { click_link 'Home' }
        it { should_not have_error_message }
      end
    end

    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in(user)
      end

      it { should have_title(user.name) }
      it { should have_link('Users', href: users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should have_link('Recipes', href: recipes_path) }

      it { should have_success_message }

      it { should_not have_link('Sign in', href: signin_path) }

      describe 'after signout' do
        before { click_link 'Sign out' }

        it { should have_link 'Sign in' }

        it { should_not have_link 'Users' }
        it { should_not have_link 'Profile' }
        it { should_not have_link 'Settings' }
        it { should_not have_link 'Sign out' }
        it { should_not have_link 'Recipes' }

        it { should have_success_message }
      end
    end
  end

  describe 'authorization' do
    describe 'for signed-in users' do
      let(:user) { FactoryGirl.create :user }

      before { sign_in user, no_capybara: true }

      describe 'in the Users controller' do
        describe 'submitting to the new action' do
          before { get new_user_path }
          specify { expect(response).to redirect_to root_url }
        end

        describe 'submitting to the create action' do
          before { post users_path }
          specify { expect(response).to redirect_to root_url }
        end
      end
    end
    describe 'for non-signed-in users' do
      let(:user) { FactoryGirl.create(:user) }

      describe 'in the Users controller' do
        describe 'visiting the edit page' do
          before { visit edit_user_path(user) }
          it { should have_title('Sign In') }
        end

        describe 'submitting to the update action' do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe 'visiting the user index' do
          before { visit users_path }
          it { should have_title('Sign In') }
        end
      end

      describe 'when attempting to visit a protected page' do
        before do
          visit edit_user_path(user)
          fill_in 'Email', with: user.email
          fill_in 'Password', with: user.password
          click_button 'Sign in'
        end

        describe 'after signing in' do
          it 'should render the desired protected page' do
            expect(page).to have_title('Edit user')
          end

          describe 'when signing in again' do
            before do
              delete signout_path
              sign_in user
            end

            it 'should render the default page' do
              expect(page).to have_title user.name
            end
          end
        end
      end

      describe 'as non-admin user' do
        let(:user) { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }

        before { sign_in non_admin, no_capybara: true }

        describe 'submitting a DELETE request to the Users#destroy action' do
          before { delete user_path(user) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end

      describe 'as admin user' do
        let(:admin) { FactoryGirl.create :admin }
        before { sign_in admin, no_capybara: true }

        describe 'trying to delete self via DELETE' do
          it 'should not be able to destroy itself' do
            expect { delete user_path(admin) }.not_to change(User, :count)
          end

          describe 'redirection' do
            before { delete user_path(admin) }

            it 'should redirect to users url' do
              expect { response.to redirect_to users_url }
              flash[:notice].should eq 'Cannot delete self'
            end
          end
        end
      end

      describe 'in the Recipes controller' do
        describe 'submitting to the create action' do
          before { post recipes_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe 'submitting to the destroy action' do
          before { delete recipe_path(FactoryGirl.create(:recipe)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end

    describe 'as wrong user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }
      before { sign_in user, no_capybara: true }

      describe 'submitting a GET request to the Users#edit action' do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe 'submitting a PATCH request to the Users#update action' do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe 'in the recipes controller' do
        describe 'submitting a DELETE request to the Recipes#destroy' do
          let(:recipe) { FactoryGirl.create(:recipe, user: wrong_user) }
          before { delete recipe_path(recipe) }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe 'submitting a PATCH request to the Recipes#update' do
          let(:recipe) { FactoryGirl.create(:recipe, user: wrong_user) }
          before { patch recipe_path(recipe) }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe 'submitting a GET request to the Recipes#update' do
          let(:recipe) { FactoryGirl.create(:recipe, user: wrong_user) }
          before { get edit_recipe_path(recipe) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end
    end
  end
end
