class BlogPostFilterService
  def initialize(posts = BlogPost.all)
    @posts = posts
  end

  def by_author(author_id)
    return self if author_id.blank?

    @posts = @posts.where(author_id: author_id)
    self
  end

  def with_feedback
    @posts = @posts.joins(:feedbacks).distinct
    self
  end

  def without_feedback
    @posts = @posts.left_joins(:feedbacks).where(feedbacks: { id: nil })
    self
  end

  def results
    @posts
  end
end
