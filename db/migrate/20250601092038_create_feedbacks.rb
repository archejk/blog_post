class CreateFeedbacks < ActiveRecord::Migration[7.2]
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.text :message
      t.references :blog_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
