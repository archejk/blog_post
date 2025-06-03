class Feedback < ApplicationRecord
  belongs_to :blog_post
  belongs_to :user

  validates :message, presence: true, length: { minimum: 5 }
  validate :author_cannot_submit_feedback_on_own_post

  after_create :send_feedback_email

  # def name
  #   user.display_name
  # end

  # def email
  #   user.email
  # end

  private

  def send_feedback_email
    begin
      FeedbackMailer.send_feedback(self).deliver_now
      Rails.logger.info "Feedback email sent successfully for feedback ##{id}" if Rails.env.development?
    rescue => e
      Rails.logger.error "Failed to send feedback email: #{e.message}" if Rails.env.development?
    end
  end

  def author_cannot_submit_feedback_on_own_post
    if blog_post&.author_email&.downcase == email&.downcase
      errors.add(:email, "Authors cannot leave feedback on their own posts")
    end
  end
end
