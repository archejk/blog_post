class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blog_posts, foreign_key: "author_id", dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_one_attached :avatar

  validates :name, presence: true

  def display_name
    name.present? ? name : email.split("@").first
  end
end
