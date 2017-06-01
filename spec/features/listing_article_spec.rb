require "rails_helper"

RSpec.feature "Listing Articles" do
  
  before do
    @article1 = Article.create(title: "First Article", body: "Lorem Ippsm 1")
    
    @article2 = Article.create(title: "Second Article", body: "Second Lorem Ippsm")
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