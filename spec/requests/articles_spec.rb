require "rails_helper"

RSpec.describe "Articles", type: :request do
  
  before do
    @test_user = User.create(email: "user@test-mail.com", password: "password")
    @fred = User.create(email: "fred@test-mail.com", password: "password")
    @article = Article.create!(title: "Test Title", body: "test Body", user: @test_user)
  end
  
  describe "GET /articles/:id/edit" do
    context "with non-signed in user" do
      before { get "/articles/#{@article.id}/edit"}
      
      it "redirects to the sign in page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context "with signed in user who is non-owner" do
      before do
        login_as(@fred)
        get "/articles/#{@article.id}/edit"
      end
      
      it "redirects to home page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own article."
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context "with signed in user successfull edit" do
      before do
        login_as(@test_user)
        get "/articles/#{@article.id}/edit"
      end
      
      it "successfully edit article" do
        expect(response.status).to eq 200
      end
    end
  end
  
  describe "DELETE /articles/:id" do
    context "with non-signed in user" do
      before { delete "/articles/#{@article.id}"}
      
      it "redirects to the sign in page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context "with signed in user who is non-owner" do
      before do
        login_as(@fred)
        delete "/articles/#{@article.id}"
      end
      
      it "redirects to home page" do
        expect(response.status).to eq 302
        flash_message = "You can only delete your own article."
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context "with signed in user successfull delete" do
      before do
        login_as(@test_user)
        delete "/articles/#{@article.id}"
      end
      
      it "successfully delete article" do
        expect(response.status).to eq 302
        flash_message = "Article has been deleted"
        expect(flash[:success]).to eq flash_message
      end
    end
  end
  
  describe "GET /articles/:id" do
    context "within existing article" do
      before { get "/articles/#{@article.id}"}
      it 'handles existing article' do
        expect(response.status).to eq 200
      end
    end
    
    context 'with non-existing article' do
      before { get "/articles/xxx"}
      
      it 'handles non-existing article' do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end