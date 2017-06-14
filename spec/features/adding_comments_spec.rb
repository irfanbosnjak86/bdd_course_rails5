require "rails_helper"

RSpec.feature "Adding comments to Articles" do
  before do
    @test_user = User.create(email: "user@test-mail.com", password: "password")
    @fred = User.create(email: "fred@test-mail.com", password: "password")
    @article = Article.create!(title: "Test Title", body: "test Body", user: @test_user)
  end
  
  scenario "permits a signed in user to write comments" do
    login_as(@fred)
    
    visit "/"
    
    click_link @article.title 
    fill_in "New Comment", with: "An Amazing Article"
    click_button "Add Comment"
    
    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An Amazing Article")
    expect(current_path).to eq(article_path(@article.id))
  end
end