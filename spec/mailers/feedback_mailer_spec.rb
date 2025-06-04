require "rails_helper"

RSpec.describe FeedbackMailer, type: :mailer do
  describe "#send_feedback" do
    let(:author) { double("User", name: "Taylor Swift", email: "taylor@example.com") }
    let(:blog_post) { double("BlogPost", title: "All Of The Girls You Loved Before", author: author) }
    let(:feedback) do
      double(
        "Feedback",
        blog_post: blog_post,
        name: "Joe Alwyn",
        email: "joe@example.com",
        message: "Niceee!!! :)))"
      )
    end

    subject(:mail) { described_class.send_feedback(feedback) }

    it "renders the subject" do
      expect(mail.subject).to eq("New feedback on your blog post: All Of The Girls You Loved Before")
    end

    it "sends to the blog post author's email" do
      expect(mail.to).to eq([ "taylor@example.com" ])
    end

    it "sends from the default email" do
      expect(mail.from).to eq([ "archejewelkim@gmail.com" ])
    end

    it "includes blog post title and author name in the body" do
      expect(mail.body.encoded).to include("All Of The Girls You Loved Before")
      expect(mail.body.encoded).to include("Taylor Swift")
    end

    it "includes feedback sender info in the body" do
      expect(mail.body.encoded).to include("Joe Alwyn")
      expect(mail.body.encoded).to include("joe@example.com")
      expect(mail.body.encoded).to include("Niceee!!! :)))")
    end
  end
end
