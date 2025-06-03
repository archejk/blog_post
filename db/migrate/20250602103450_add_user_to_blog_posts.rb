class AddUserToBlogPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :blog_posts, :author, null: false, foreign_key: { to_table: :users }
  end
end
