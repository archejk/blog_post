class FeedbacksController < ApplicationController
  before_action :set_blog_post

  def create
    puts "CHECKPOINT 1"
    @feedback = @blog_post.feedbacks.build(feedback_params)

    Rails.logger.info "Creating feedback with params: #{feedback_params.inspect}"
    Rails.logger.info "Blog post author email: #{@blog_post.author_email}"

    if @feedback.save
      puts "CHECKPOINT 2"
      Rails.logger.info "Feedback saved successfully with ID: #{@feedback.id}"
      redirect_to @blog_post, notice: "Thank you for your feedback! The author has been notified."
    else
      Rails.logger.error "Feedback validation failed: #{@feedback.errors.full_messages}"
      # Re-render the show page with errors
      render "blog_posts/show", status: :unprocessable_entity
    end
  rescue StandardError => e
    Rails.logger.error "Feedback creation error: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")

    @feedback ||= @blog_post.feedbacks.build
    flash.now[:alert] = "There was an error submitting your feedback. Please try again."
    render "blog_posts/show", status: :unprocessable_entity
  end

  # def create
  #   puts "CHECKPOINT 1"
  #   @blog_post = BlogPost.find(params[:blog_post_id])
  #   @feedback = @blog_post.feedbacks.build(feedback_params)

  #   if @feedback.save
  #     puts "CHECKPOINT 1"
  #     redirect_to @blog_post, notice: "Thank you for your feedback!"
  #   else
  #     redirect_to @blog_post, alert: "Something went wrong. Please try again."
  #   end
  # end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end

  def feedback_params
    params.require(:feedback).permit(:name, :email, :message, :blog_post_id)
  end
end
