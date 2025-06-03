class RemoveAuthorFieldsFromBlogPosts < ActiveRecord::Migration[7.2]
  def change
    remove_column :blog_posts, :author_name, :string
    remove_column :blog_posts, :author_email, :string
  end
end
