require "rails_helper"

RSpec.feature "Showing Article" do
  before do
    @fred = User.create(email: "fred@test-mail.com", password: "password")
    @test_user = User.create(email: "user@test-mail.com", password: "password")
    @article = Article.create(title: "First Article", body: "Lorem Ippsm 1", user: @test_user)
  end
  
  scenario "to non signed in users hide the edit and delete buttons" do
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  
  scenario "to non-owner users hide the edit and delete buttons" do
    login_as(@fred)
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
end