require 'spec_helper'

describe Unit do
  it { should respond_to(:name) }

  it { should validate_uniqueness_of(:name) }
  it { should ensure_length_of(:name).is_at_least(2).is_at_most(60) }
  it { should allow_value("Kilograms").for(:name) }
  it { should_not allow_value("Kilog$ms").for(:name) }

  it { should validate_presence_of(:abbreviation) }
  it { should validate_uniqueness_of(:abbreviation) }
  it { should ensure_length_of(:abbreviation).is_at_least(1).is_at_most(10) }
  it { should allow_value('kg').for(:abbreviation) }
  it { should_not allow_value('{').for(:abbreviation) }

  it { should have_many(:ingredients) }
end
