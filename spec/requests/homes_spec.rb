require 'spec_helper'

describe "Home Page" do
  it "should have content 'Cooking Helper'" do
    visit "/"
    expect(page).to have_content("Cooking Helper")
  end

  it "should have a correct title" do
    visit "/"
    expect(page).to have_title("Cooking Helper | Home")
  end
end