require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:feedbacks).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe 'scopes' do
    describe '.recent' do
      let!(:old_post) { create(:blog_post, created_at: 2.days.ago) }
      let!(:new_post) { create(:blog_post, created_at: 1.day.ago) }
      let!(:newest_post) { create(:blog_post, created_at: 1.hour.ago) }

      it 'returns posts ordered by creation date descending' do
        expect(BlogPost.recent).to eq([ newest_post, new_post, old_post ])
      end
    end
  end

  describe '#author_name' do
    context 'when author has a name' do
      let(:author) { create(:user, name: 'Taylor Swift') }
      let(:blog_post) { create(:blog_post, author: author) }

      it 'returns the author display name' do
        expect(blog_post.author_name).to eq('Taylor Swift')
      end
    end
  end
end
