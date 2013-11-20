require 'spec_helper'

describe "Home Page" do
  subject { page }
  describe "when not signed in" do
    before { visit root_path }

    it { should have_header 'Cooking Helper' }
    it { should have_title(full_title 'Home') }
    it { should have_content('Sign Up') }
    it { should have_content('Sign In') }

    it "should have all links working" do
      visit root_path

      click_link "Cooking Helper"
      expect(page).to have_title(full_title 'Home')

      click_link "Cooking Helper"
      click_link "Sign Up"
      expect(page).to have_title(full_title 'Sign Up')

      click_link "Cooking Helper"
      expect(page).to have_title("Home")

      click_link "Sign In"
      expect(page).to have_title("Sign In")
    end
  end

  describe "when signed in" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
      visit root_path
    end

    it { should_not have_link('Sign up') }
  end
end