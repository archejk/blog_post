require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:blog_post) { create(:blog_post) }

    before do
      sign_in user
    end

    context 'with valid parameters' do
      let(:valid_params) do
        {
          blog_post_id: blog_post.id,
          feedback: { message: 'Niceeee!!! :)))' }
        }
      end

      it 'creates a new feedback and redirects to the blog post' do
        expect {
          post :create, params: valid_params
        }.to change(Feedback, :count).by(1)

        feedback = Feedback.last
        expect(feedback.user).to eq(user)
        expect(feedback.name).to eq(user.name)
        expect(feedback.email).to eq(user.email)
        expect(response).to redirect_to(blog_post)
        expect(flash[:notice]).to eq("Thank you for your feedback! The author has been notified.")
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          blog_post_id: blog_post.id,
          feedback: { message: '' }
        }
      end

      it 'does not save feedback and renders the blog post show template' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Feedback, :count)

        expect(response).to render_template('blog_posts/show')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when an exception occurs' do
      before do
        allow_any_instance_of(Feedback).to receive(:save).and_raise(StandardError, 'Something went wrong')
      end

      it 'rescues the exception and renders the show template with alert' do
        post :create, params: {
          blog_post_id: blog_post.id,
          feedback: { message: 'Niceeee!!! :)))' }
        }

        expect(response).to render_template('blog_posts/show')
        expect(flash.now[:alert]).to eq('There was an error submitting your feedback. Please try again.')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
