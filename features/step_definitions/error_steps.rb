Then(/^they should (?:receive|get) an error message$/) do
  expect(page).to have_selector('div.alert.alert-danger')
end
Then(/^a success message should be displayed$/) do
  expect(page).to have_selector('div.alert.alert-success')
end
Then(/^they should receive a success message$/) do
  expect(page).to have_selector('div.alert.alert-success')
end
