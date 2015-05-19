Given(/^I launch my device with Prosper home page$/) do
  launch_driver
  home_screen.get_home
end


And(/^I set "(.*?)" as loan amount needed$/) do |amount|
  page_actions.wait_for_element_displayed(60){home_screen.loan_amount}
  home_screen.loan_amount.send_keys amount
end


Then(/^I select "(.*?)" as loan purpose$/) do |purpose|
  home_screen.loan_purpose.find_elements(:tag_name, "option").select {|el| el.text == purpose}.first.click
end


Then(/^I select "(.*?)" as credit score$/) do |score|
  home_screen.credit_score.find_elements(:tag_name, "option").select {|el| el.text.include?(score)}.first.click
end


Then(/^I click on "([^"]*)"(?: button|image|area)? on "([^"]*)"$/) do |element, screen|
  send(screen.downcase.tr(' ', '_')).send(element.downcase.tr(' ', '_')).click
end


Then(/^I expect to be on get custom rate screen$/) do
  page_actions.wait_for_element_exists(60){get_rate_screen.get_rates}
  expect(get_rate_screen.get_rates.text).to be == "Get a Custom Rate in 1 Click"
end

