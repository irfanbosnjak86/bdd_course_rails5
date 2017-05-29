require "rails_helper"

RSpec.feature "Creating Articles" do
  scenario "A user creates new Article" do
    visit "/" 
    
    click_link "New Article"
    
    fill_in "Title", with: "Creating Test Title"
    fill_in "Body", with: "Lorem Ipsum"
    
    click_button "Create Article"
    
    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
  end
end