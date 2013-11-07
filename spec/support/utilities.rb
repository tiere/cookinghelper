include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

def fill_recipe_info
  fill_in "recipe_name", with: "Kaalilaatikko"
  select('Soup', from: "recipe_category_id")

  select('Corn', from: 'recipe_ingredients_attributes_0_foodstuff_id')
  fill_in('recipe_ingredients_attributes_0_quantity', with: 1 )
  select('Kilograms', from: 'recipe_ingredients_attributes_0_unit_id')

  select('Corn', from: 'recipe_ingredients_attributes_1_foodstuff_id')
  fill_in('recipe_ingredients_attributes_1_quantity', with: 2 )
  select('Kilograms', from: 'recipe_ingredients_attributes_1_unit_id')

  select('Corn', from: 'recipe_ingredients_attributes_2_foodstuff_id')
  fill_in('recipe_ingredients_attributes_2_quantity', with: 3 )
  select('Kilograms', from: 'recipe_ingredients_attributes_2_unit_id')

  fill_in("recipe_steps_attributes_0_name", with: "Boiling")
  fill_in("recipe_steps_attributes_0_duration_h", with: '1')

  fill_in("recipe_steps_attributes_1_name", with: "Cutting")
  fill_in("recipe_steps_attributes_1_duration_h", with: '1')

  fill_in("recipe_steps_attributes_2_name", with: "Slicing")
  fill_in("recipe_steps_attributes_2_duration_h", with: '1')
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert-box.alert', text: message)
  end
end

RSpec::Matchers.define :have_header do |text|
  match do |page|
    expect(page).to have_selector('h2', text: text)
  end
end

RSpec::Matchers.define :have_field_error do |message|
  match do |page|
    expect(page).to have_selector('small.error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert-box.success', text: message)
  end
end

RSpec::Matchers.define :have_pagination_selector do
  match do |page|
    expect(page).to have_selector('ul.pagination')
  end
end