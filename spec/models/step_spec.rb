require 'spec_helper'

describe Step do
  it { should respond_to(:name) }
  it { should respond_to(:duration) }

  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_least(2).is_at_most(60) }
  it { should allow_value("Boiling").for(:name) }
  it { should allow_value("Boiling 2").for(:name) }
  it { should_not allow_value('Bo%^ling').for(:name) }

  it { should validate_presence_of(:duration) }
  it { should ensure_inclusion_of(:duration).in_range(60..86400)
       .with_message('must be between 1 minute and 24 hours') }
  it { should validate_numericality_of(:duration).only_integer }

  it { should belong_to(:recipe) }
end