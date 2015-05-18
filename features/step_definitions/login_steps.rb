Given(/^I launch my device with Distil Networks page$/) do
  launch_driver
  home_screen.get_home
end

And(/^I press on expand menu button$/) do
  home_screen.expand_menu.click
end

Then(/^I press on Signin button$/) do
  page_actions.wait_for_element_displayed(60){home_screen.sign_in}
  home_screen.sign_in.click
end

Then(/^I type email "(.*?)" on login page$/) do |email|
  page_actions.wait_for_element_exists(60){signin_screen.email_field}
  signin_screen.email_field.send_keys(email)
end

Then(/^T type password "(.*?)" on login page$/) do |password|
  signin_screen.password_field.send_keys(password)
end

When(/^I press on SignIn on login page$/) do
  signin_screen.signin_btn.click
end

Then(/^I expect to see error "(.*?)"$/) do |message|
  page_actions.wait_for_element_exists(60){signin_screen.errors}
  expect(signin_screen.errors.text).to be == message
end

