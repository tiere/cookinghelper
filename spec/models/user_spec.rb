require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Jack Sharper", email: "jack.sharper@example.com",
                     password: "jellyfish", password_confirmation: "jellyfish")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:recipes) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 31 }
    it {should_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[name@foo,com name_at_foo.org example.user@foo.
        foo@bar_baz.com foo@bar+baz.com hemuli.tati@testi..fi]

      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Essi.Esimerkki@example.fi" }

    it "should be saved as all lower case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[essi.esimerkki@joo.fi teppo@jaa.joo.com a+b@example.com]

      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address has already been taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it {should_not be_valid}
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "example.user@jaa.com",
                       password: " ", password_confirmation: " ")
    end

    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "otherthanpassword" }

    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "remember_token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "recipe associations" do

    before { @user.save }

    let!(:recipe_1) { FactoryGirl.create(:recipe, user: @user) }
    let!(:recipe_2) { FactoryGirl.create(:recipe, user: @user) }

    it "should have the right recipes" do
      expect(@user.recipes.to_a.sort).to eq [recipe_1, recipe_2].sort
    end

    it "should destroy associates recipes" do
      recipes = @user.recipes.to_a
      @user.destroy
      expect(recipes).not_to be_empty
      recipes.each do |recipe|
        expect(Recipe.where(id: recipe.id)).to be_empty
      end
    end
  end
end