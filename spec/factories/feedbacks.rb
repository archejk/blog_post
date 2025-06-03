FactoryBot.define do
  factory :feedback do
    message { "Niceee!!! :))" }
    association :user
    association :blog_post
  end
end
