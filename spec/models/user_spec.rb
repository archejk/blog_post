require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:blog_posts).with_foreign_key('author_id').dependent(:destroy) }
    it { should have_many(:feedbacks).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
  end

  describe '#display_name' do
    context 'when name is present' do
      let(:user) { create(:user, name: 'Joe Alwyn', email: 'joe@example.com') }

      it 'returns the name' do
        expect(user.display_name).to eq('Joe Alwyn')
      end
    end
  end
end
