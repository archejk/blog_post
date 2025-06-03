class Feedback < ApplicationRecord
  belongs_to :blog_post
  belongs_to :user

  validates :message, presence: true, length: { minimum: 5 }

  after_create :send_feedback_email

  private

  def send_feedback_email
    begin
      FeedbackMailer.send_feedback(self).deliver_later
    rescue => e
      Rails.logger.error "Failed to send feedback email: #{e.message}"
    end
  end
end
