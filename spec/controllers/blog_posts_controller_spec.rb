require 'rails_helper'

RSpec.describe BlogPostsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let!(:blog_post) { create(:blog_post, author: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { page: 1 }
      expect(response).to be_successful

      posts = assigns(:posts)
      expect(posts).to be_present
      expect(posts.map(&:id)).to include(blog_post.id)

      expect(assigns(:filter_params)).not_to be_nil
      expect(assigns(:authors)).to include([ user.id, user.name ])
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: blog_post.id }
      expect(response).to be_successful
      expect(assigns(:feedback)).to be_a_new(Feedback)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new BlogPost and redirects" do
        expect {
          post :create, params: { blog_post: { title: "New Post", content: "Post content" } }
        }.to change(BlogPost, :count).by(1)
        expect(response).to redirect_to(BlogPost.last)
      end
    end

    context "with invalid params" do
      it "renders the new template with errors" do
        post :create, params: { blog_post: { title: "", content: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates the blog post and redirects" do
        patch :update, params: { id: blog_post.id, blog_post: { title: "Updated Title" } }
        expect(blog_post.reload.title).to eq("Updated Title")
        expect(response).to redirect_to(blog_post)
      end
    end

    context "with invalid params" do
      it "renders the edit template with errors" do
        patch :update, params: { id: blog_post.id, blog_post: { title: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested blog post" do
      expect {
        delete :destroy, params: { id: blog_post.id }
      }.to change(BlogPost, :count).by(-1)
      expect(response).to redirect_to(blog_posts_url)
    end
  end
end
