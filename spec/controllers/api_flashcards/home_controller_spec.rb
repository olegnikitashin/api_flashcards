require 'rails_helper'
require 'support/auth_helper.rb'

module ApiFlashcards
  RSpec.describe HomeController, type: :controller do
    routes { ApiFlashcards::Engine.routes }

    include AuthHelper

    describe "GET #index" do
      it "returns http success with right credentials" do
        http_login
        get :index
        expect(response).to have_http_status(:success)
      end

      it "returns 401 Unauthorised status without credentials" do
        get :index
        expect(response.status).to eq 401
      end

      it "returns 401 Unauthorised status with wrong credentials" do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('notadmin', 'wrong')
        get :index
        expect(response.status).to eq 401
      end
    end
  end
end
