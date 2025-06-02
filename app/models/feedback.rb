class Feedback < ApplicationRecord
  belongs_to :blog_post

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true, length: { minimum: 5 }
  validate :author_cannot_submit_feedback_on_own_post

  after_create :send_feedback_email

  private

  def send_feedback_email
    begin
      FeedbackMailer.send_feedback(self).deliver_now
      Rails.logger.info "Feedback email sent successfully for feedback ##{id}"
    rescue => e
      Rails.logger.error "Failed to send feedback email: #{e.message}"
    end
  end

  def author_cannot_submit_feedback_on_own_post
    if blog_post&.author_email&.downcase == email&.downcase
      errors.add(:email, "Authors cannot leave feedback on their own posts")
    end
  end
end
