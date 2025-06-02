class FeedbacksController < ApplicationController
  before_action :set_blog_post

  def create
    puts "CHECKPOINT 1" if Rails.env.development?
    @feedback = @blog_post.feedbacks.build(feedback_params)

    if @feedback.save
      puts "CHECKPOINT 2" if Rails.env.development?
      redirect_to @blog_post, notice: "Thank you for your feedback! The author has been notified."
    else
      render "blog_posts/show", status: :unprocessable_entity
    end
  rescue StandardError => e
    @feedback ||= @blog_post.feedbacks.build
    flash.now[:alert] = "There was an error submitting your feedback. Please try again."
    render "blog_posts/show", status: :unprocessable_entity
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end

  def feedback_params
    params.require(:feedback).permit(:name, :email, :message, :blog_post_id)
  end
end
