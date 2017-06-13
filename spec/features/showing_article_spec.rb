require "rails_helper"

RSpec.feature "Showing Article" do
  before do
    test_user = User.create(email: "user@test-mail.com", password: "password")
    login_as(test_user)
    @article = Article.create(title: "First Article", body: "Lorem Ippsm 1", user: test_user)
  end
  
  scenario "A user shows article" do
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    
    expect(current_path).to eq(article_path(@article))
  end
end