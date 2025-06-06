require 'rails_helper'

RSpec.describe BlogPostFilterService do
  let!(:author1) { create(:user) }
  let!(:author2) { create(:user) }

  let!(:post1) { create(:blog_post, author: author1) }
  let!(:post2) { create(:blog_post, author: author2) }
  let!(:post3) { create(:blog_post, author: author1) }

  let!(:feedback1) { create(:feedback, blog_post: post1) }

  describe "#by_author" do
    it "returns all blog posts if author_id is blank" do
      service = described_class.new(BlogPost.all)
      expect(service.by_author(nil).results).to match_array([ post1, post2, post3 ])
    end

    it "returns blog posts only by the specified author if user select an author on the dropdown" do
      service = described_class.new(BlogPost.all)
      result = service.by_author(author1.id).results
      expect(result).to match_array([ post1, post3 ])
      expect(result).not_to include(post2)
    end
  end

  describe "#with_feedback" do
    it "returns blog posts that have feedback" do
      service = described_class.new(BlogPost.all)
      result = service.with_feedback.results
      expect(result).to include(post1)
      expect(result).not_to include(post2, post3)
    end
  end

  describe "#without_feedback" do
    it "returns blog posts without feedback" do
      service = described_class.new(BlogPost.all)
      result = service.without_feedback.results
      expect(result).to include(post2, post3)
      expect(result).not_to include(post1)
    end
  end
end
