require 'rails_helper'

RSpec.describe "Feedbacks", type: :request do
  let!(:user) { User.create!(email: "taylor@example.com", password: "password", name: "Taylor Swift") }
  let!(:blog_post) { BlogPost.create!(title: "All of the Girls You Loved Before", content: "All of the Girls You Loved Before, But I love you more", author: user) }

  before do
    sign_in user
  end

  describe "POST /blog_posts/:blog_post_id/feedbacks" do
    it "creates feedback and redirects" do
      post "/blog_posts/#{blog_post.id}/feedbacks", params: {
        feedback: { message: "Slayyy, niceee!!! :)" }
      }

      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include("Slayyy, niceee!!! :)")
    end
  end
end
