
Then(/^they should (?:receive|get) an error message$/) do
  expect(page).to have_selector('div.alert.alert-danger')
end
