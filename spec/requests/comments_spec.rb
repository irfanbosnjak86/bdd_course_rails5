require "rails_helper"

RSpec.describe "Comments", type: :request do
  
  before do
    @test_user = User.create(email: "user@test-mail.com", password: "password")
    @fred = User.create(email: "fred@test-mail.com", password: "password")
    @article = Article.create!(title: "Test Title", body: "test Body", user: @test_user)
  end
  
  describe 'POST /articles/:id/comments/' do
    context 'with a non-signed in user' do
      before do
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome Blog"}}
      end
      
      it 'redirects user to signin page' do
        flash_message = "Please sign in or sign up first"
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context "with a loged in user" do
      
      before do
        login_as(@fred) 
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome Blog"}}
      end
      
      it 'creates comment successfully' do
        flash_message = "Comment has been created"
        expect(response).to redirect_to(article_path(@article.id))
        expect(response.status).to eq 302
        expect(flash[:notice]).to eq flash_message
      end
    end
  end
  
end