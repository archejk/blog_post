# Preview all emails at http://localhost:3000/rails/mailers/feedback_mailer_mailer
class FeedbackMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/feedback_mailer_mailer/send_feedback
  def send_feedback
    feedback = Feedback.last
    FeedbackMailer.send_feedback(feedback)
  end
end
