include ApplicationHelper

def sign_in(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
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