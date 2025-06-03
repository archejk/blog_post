module BlogPostsHelper
  def owner_of_post?(blog_post)
    current_user == blog_post.author
  end
end
