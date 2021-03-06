require 'spec_helper'

describe 'User pages' do
  subject { page }

  describe 'index' do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe 'pagination' do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('ul.pagination') }

      it 'should list each user' do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('div', text: user.name)
        end
      end
    end

    describe 'delete links' do
      it { should_not have_link('delete') }

      describe 'as an admin user' do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it 'should be able to delete another user' do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end

        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:recipe1) { FactoryGirl.create(:recipe, user: user) }
    let!(:recipe2) { FactoryGirl.create(:recipe, user: user) }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe 'recipes' do
      it { should have_link(recipe1.name, href: recipe_path(recipe1)) }
      it { should have_link(recipe2.name, href: recipe_path(recipe2)) }
      it { should have_content(user.recipes.count) }
    end
  end

  describe 'signup page' do
    before { visit signup_path }

    it { should have_content('Sign Up') }
    it { should have_title(full_title('Sign Up')) }
  end

  describe 'signup' do
    before { visit signup_path }

    let(:submit) { 'Create Account' }

    describe 'with invalid information' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe 'after submission' do
        before { click_button submit }

        it { should have_title('Sign Up') }
        it { should have_field_error "can't be blank" }
      end
    end

    describe 'with valid information' do
      before do
        fill_in 'Name', with: 'Pertti'
        fill_in 'Email', with: 'pertti@example.com'
        fill_in 'Password', with: 'fishsticks'
        fill_in 'Confirmation', with: 'fishsticks'
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:user) { User.find_by(email: 'pertti@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_success_message 'Account successfully created' }
      end
    end
  end

  describe 'edit' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe 'page' do
      it { should have_content('Update your profile') }
      it { should have_title('Edit user') }
      it do
        should have_link('Change Gravatar',
                         href: 'http://gravatar.com/emails')
      end
    end

    describe 'with invalid information' do
      before { click_button 'Update Information' }

      it { should have_field_error 'is too short' }
    end

    describe 'with valid information' do
      let(:new_name) { 'New Name' }
      let(:new_email) { 'new.email@example.com' }

      before do
        fill_in 'Name', with: new_name
        fill_in 'Email', with: new_email
        fill_in 'Password', with: user.password
        fill_in 'Confirmation', with: user.password
        click_button 'Update Information'
      end

      it { should have_title(new_name) }
      it { should have_success_message 'Changes successfully saved' }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe 'forbidden attributes' do
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
      end

      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end

      specify { expect(user.reload).not_to be_admin }
    end
  end
end
