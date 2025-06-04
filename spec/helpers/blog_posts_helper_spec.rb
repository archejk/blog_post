require 'rails_helper'

RSpec.describe BlogPostsHelper, type: :helper do
  let(:user) { double('User') }
  let(:author) { double('User') }

  let(:blog_post) { double('BlogPost', author: author) }

  before do
    # Stub current_user helper method
    allow(helper).to receive(:current_user).and_return(current_user)
  end

  context "when current_user is the author of the post" do
    let(:current_user) { author }

    it "returns true" do
      expect(helper.owner_of_post?(blog_post)).to be true
    end
  end

  context "when current_user is not the author of the post" do
    let(:current_user) { user }

    it "returns false" do
      expect(helper.owner_of_post?(blog_post)).to be false
    end
  end
end
