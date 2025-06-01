FactoryBot.define do
  factory :feedback do
    name { "MyString" }
    email { "MyString" }
    message { "MyText" }
    blog_post { nil }
  end
end
