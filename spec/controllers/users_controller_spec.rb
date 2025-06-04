require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:valid_params) do
        {
          user: {
            name: 'New Name',
            email: 'newemail@example.com'
          }
        }
      end

      it 'updates the user and redirects' do
        patch :update, params: valid_params
        user.reload
        expect(user.name).to eq('New Name')
        expect(user.email).to eq('newemail@example.com')
        expect(response).to redirect_to(user_path)
        expect(flash[:notice]).to eq('Profile successfully updated!')
      end
    end
  end
end
