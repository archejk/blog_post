class BlogPost < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :feedbacks, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def author_name
    author.display_name
  end
end
