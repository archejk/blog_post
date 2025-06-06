require 'rails_helper'

RSpec.describe "BlogPosts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:blog_post) { FactoryBot.create(:blog_post, author: user) }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "returns http success" do
      get blog_posts_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get blog_post_path(blog_post)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_blog_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a blog post and returns redirect" do
      post blog_posts_path, params: { blog_post: { title: "New Post", content: "Some content" } }
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include("New Post")
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_blog_post_path(blog_post)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "updates the blog post and returns redirect" do
      patch blog_post_path(blog_post), params: { blog_post: { title: "Updated Title" } }
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include("Updated Title")
    end
  end

  describe "DELETE /destroy" do
    it "deletes the blog post and redirects" do
      delete blog_post_path(blog_post)
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).not_to include(blog_post.title)
    end
  end
end
