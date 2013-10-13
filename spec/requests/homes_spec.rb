require 'spec_helper'

describe "Home Page" do
  subject { page }
  before { visit root_path }

  it { should have_content("Cooking Helper") }
  it { should have_title(full_title('Home')) }
end