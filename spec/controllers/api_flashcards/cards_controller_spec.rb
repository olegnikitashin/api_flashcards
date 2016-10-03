require 'rails_helper'
require "json_matchers/rspec"
require 'support/auth/auth_helper.rb'

def card_object(user)
  block = user.cards.first.block.id
  { original_text: "banana", translated_text: "банан", block_id: block }
end

module ApiFlashcards
  RSpec.describe Api::V1::CardsController, type: :controller do
    routes { ApiFlashcards::Engine.routes }
    include AuthHelper

    let(:user) { create :user_with_one_block_and_one_card }

    context "non-authenticated access" do
      describe "GET cards#index" do
        it "returns a 401 status" do
          get :index
          expect(response.status).to eq 401
        end
      end

      describe "POST cards#index" do
        context "invalid parameters passed" do
          it "returns a 401 status" do
            card = card_object(user)
            wrong = { original_text: '' }
            card = card.merge(wrong)
            post :create, params: { 'card' => card }
            expect(response.status).to eq 401
          end
        end

        it "responds with a 401 status" do
          post :create, params: { 'card' => card_object(user) }
          expect(response.status).to eq 401
        end
      end
    end

    context "authenticated access" do
      before(:each) do
        http_login(user.email, user.password)
      end

      describe "GET cards#index" do
        before (:each) do
          get :index
        end

        it "returns a 200 status" do
          expect(response.status).to eq 200
        end

        it "returns a valid card object" do
          expect(response).to match_response_schema('cards')
        end

        it "responds to ajax by default" do
          expect(response.content_type).to eq 'application/json'
        end
      end

      describe "POST cards#index" do
        context "invalid parameters passed" do
          it "returns a 400 status" do
            card = card_object(user)
            wrong = { original_text: '' }
            card = card.merge(wrong)
            post :create, params: { 'card' => card }
            expect(response.status).to eq 400
          end
        end

        context "valid parameters passed" do
          it "responds with a newly created object" do
            expect do
              post :create, params: { 'card' => card_object(user) }
            end.to change(user.cards, :count).by 1
          end

          it "responds with a newly created object" do
            post :create, params: { 'card' => card_object(user) }
            created_card = JSON.parse(response.body)
            expect(created_card['original_text']).to eq('banana')
            expect(created_card['translated_text']).to eq('банан')
            expect(created_card['block_id']).to eq(user.cards.first.block.id)
          end

          it "responds with a newly created object" do
            post :create, params: { 'card' => card_object(user) }
            expect(response.status).to eq 200
          end

          it "responds with a newly created object" do
            post :create, params: { 'card' => card_object(user) }
            expect(response.content_type).to eq 'application/json'
          end
        end
      end
    end
  end
end
