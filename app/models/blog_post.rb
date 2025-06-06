class BlogPost < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :feedbacks, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :with_feedback, -> { joins(:feedbacks).distinct }
  scope :without_feedback, -> { left_joins(:feedbacks).where(feedbacks: { id: nil }) }

  def author_name
    author.display_name
  end
end
