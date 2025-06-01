class BlogPost < ApplicationRecord
  has_many :feedbacks, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :author_name, presence: true
  validates :author_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :recent, -> { order(created_at: :desc) }
end
