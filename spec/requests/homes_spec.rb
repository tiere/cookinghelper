require 'spec_helper'

describe "Home Page" do
  subject { page }
  before { visit root_path }

  it { should have_header 'Cooking Helper' }
  it { should have_title(full_title 'Home') }

  it "should have all links working" do
    visit root_path

    click_link "Cooking Helper"
    expect(page).to have_title(full_title 'Home')

    click_link "Cooking Helper"
    click_link "Sign up"
    expect(page).to have_title(full_title 'Sign up')
  end
end