require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new links page' do
      get :new

      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    subject(:user) do 
      User.create!(username: 'Alissa', password: '123456')
    end
    context 'invalid params' do
      it 'validates the username and password' do
        post :create, params: {user: {username: 'this is an invalid username'}}
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do
       it 'redirects to the user show page' do
          post :create, params: { user: { username: 'username', password: 'password' } }
          expect(response).to redirect_to(user_url(user.id])
        end
    end
  end




end