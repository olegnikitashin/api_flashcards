require 'rails_helper'

module ApiFlashcards
  RSpec.describe Api::V1::CardsController, type: :controller do
    routes { ApiFlashcards::Engine.routes }

    describe "GET cards#index" do
      it "returns a successful 200 response" do
        get :index, format: :json
        expect(response.status).to eq 200
      end
    end
  end
end
