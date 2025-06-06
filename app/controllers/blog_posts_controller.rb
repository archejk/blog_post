class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @filter_params = filter_params
    @authors = User.joins(:blog_posts).distinct.pluck(:id, :name)

    filtered_posts = BlogPostFilterService.new(BlogPost.recent)

    filtered_posts = filtered_posts.by_author(@filter_params[:author_id]) if @filter_params[:author_id].present?

    case @filter_params[:feedback_filter]
    when "with_feedback"
      filtered_posts = filtered_posts.with_feedback
    when "without_feedback"
      filtered_posts = filtered_posts.without_feedback
    end

    @posts = filtered_posts.results.includes(:feedbacks, :author).page(params[:page]).per(10)
  end

  def show
    @feedback = Feedback.new
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    @blog_post.author = current_user

    if @blog_post.save
      redirect_to @blog_post, notice: "Blog post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post, notice: "Blog post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to blog_posts_url, notice: "Blog post was successfully deleted."
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :content)
  end

  def filter_params
    params.permit(:author_id, :feedback_filter, :page, :commit)
  end
end
