require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe 'associations' do
    it { should belong_to(:blog_post) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:message) }
  end

  describe 'callbacks' do
    describe 'after_create' do
      let(:feedback) { build(:feedback) }
      let(:mailer_double) { double('FeedbackMailer') }
      let(:mail_double) { double('Mail::Message') }

      before do
        allow(FeedbackMailer).to receive(:send_feedback).and_return(mail_double)
        allow(mail_double).to receive(:deliver_later)
      end

      it 'calls send_feedback_email after creation' do
        expect(feedback).to receive(:send_feedback_email)
        feedback.save!
      end

      it 'sends feedback email successfully' do
        expect(FeedbackMailer).to receive(:send_feedback).with(feedback).and_return(mail_double)
        expect(mail_double).to receive(:deliver_later)
        feedback.save!
      end

      context 'when email sending fails' do
        before do
          allow(FeedbackMailer).to receive(:send_feedback).and_raise(StandardError.new('Email service down'))
          allow(Rails.logger).to receive(:error)
        end

        it 'still saves the feedback record' do
          expect { feedback.save! }.to change { Feedback.count }.by(1)
        end
      end
    end
  end
end
