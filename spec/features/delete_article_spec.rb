require "rails_helper"

RSpec.feature "Deleting Article" do
  before do
    test_user = User.create(email: "user@test-mail.com", password: "password")
    login_as(test_user)
    @article = Article.create(title: "Test Title", body: "Test Body", user: test_user)
  end
  
  scenario "A user deletes an article" do
    visit "/"
    
    click_link @article.title
    
    click_link "Delete Article"
    
    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq articles_path
  end
end