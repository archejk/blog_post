FactoryBot.define do
  factory :blog_post do
    title { "Sample Blog Post" }
    content { "Haluuu, this is a sample content" }
    association :author, factory: :user
  end
end
