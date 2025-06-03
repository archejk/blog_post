class BlogPost < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :feedbacks, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }

  scope :recent, -> { order(created_at: :desc) }

  def author_name
    author.display_name
  end
end
