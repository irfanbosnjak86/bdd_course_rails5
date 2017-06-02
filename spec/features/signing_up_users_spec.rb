require "rails_helper"

RSpec.feature "Signup Users" do
  scenario "with valid credentials" do
    visit "/"
    click_link "Sign Up"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_link "Sign Up"
    
    expect(page).to have_content("You have signed up successfully.")
  end
  
  scenario "with invalid credentials" do
    visit "/"
    click_link "Sign Up"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_link "Sign Up"
    
    # expect(page).to have_content("You have not signed up successfully.")
  end
end