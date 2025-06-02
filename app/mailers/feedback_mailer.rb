class FeedbackMailer < ApplicationMailer
  default from: "archejewelkim@gmail.com"

  def send_feedback(feedback)
    @feedback = feedback
    @blog_post = feedback.blog_post
    @author_name = @blog_post.author_name

    mail(
      to: @blog_post.author_email,
      subject: "New feedback on your blog post: #{@blog_post.title}"
    )
  end
end
