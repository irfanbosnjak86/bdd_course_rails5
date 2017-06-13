require "rails_helper"

RSpec.feature "Listing Articles" do
  
  before do
    test_user = User.create(email: "user@test-mail.com", password: "password")
    @article1 = Article.create(title: "First Article", body: "Lorem Ippsm 1", user: test_user)
    
    @article2 = Article.create(title: "Second Article", body: "Second Lorem Ippsm", user: test_user)
  end
  
  scenario "User lists all articles" do
    visit "/"
    
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    
  end
  
  scenario "User has no articles" do
    
    Article.delete_all
    
    visit "/"
    
    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)
    
    within("h1#no-articles") do
      expect(page).to have_content("No articles created")
    end
    
  end
  
end