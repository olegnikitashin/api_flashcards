require 'rails_helper'
require "json_matchers/rspec"
require 'support/auth/auth_helper.rb'
require 'levenshtein'

def card_object(user_p)
  block = user_p.cards.first.block.id
  { original_text: "banana", translated_text: "банан", block_id: block }
end

def parsed(response)
  JSON.parse(response)
end

module ApiFlashcards
  RSpec.describe Api::V1::TrainerController, type: :controller do
    routes { ApiFlashcards::Engine.routes }
    include AuthHelper

    let(:user) { create :user_with_one_block_and_one_card }

    context "non-authenticated access" do
      describe "GET trainer#index" do
        it "returns a 401 status" do
          get :index
          expect(response.status).to eq 401
        end
      end

      describe "PUT review card params" do
        it "returns 401 status" do
          card_id = user.cards.first.id
          put :review_card, params: { user_translation: "wrong", card_id: card_id }
          expect(response.status).to eq 401
        end
      end
    end

    context "authenticated access" do
      before(:each) do
        http_login(user.email, user.password)
      end

      describe "GET trainer#index" do
        it "returns a 200 status" do
          get :index
          expect(response.status).to eq 200
        end

        it "returns a valid card object" do
          get :index
          created_card = parsed(response.body)
          expect(created_card['original_text']).to eq('apple')
          expect(created_card['translated_text']).to eq('яблоко')
        end

        it "responds to ajax by default" do
          get :index
          expect(response.content_type).to eq 'application/json'
        end
      end

      describe "PUT trainer#review_card" do
        it "returns a 200 status if translation is correct" do
          card_id = user.cards.first.id
          put :review_card, params: { user_translation: "яблоко", card_id: card_id}
          expect(response.status).to eq 200
        end

        it "returns a correct translation message" do
          card_id = user.cards.first.id
          put :review_card, params: { user_translation: "яблоко", card_id: card_id}
          response_message = parsed(response.body)
          expect(response_message['message']).to eq(I18n.t(:correct_translation_notice))
        end

        it "returns an incorrect translation message" do
          card_id = user.cards.first.id
          put :review_card, params: { user_translation: "wrong", card_id: card_id}
          response_message = parsed(response.body)
          expect(response_message['message']).to eq(I18n.t(:incorrect_translation_alert))
        end

        it "returns a misprint alert message" do
          card_id = user.cards.first.id
          put :review_card, params: { user_translation: "яблок", card_id: card_id}
          response_message = parsed(response.body)
          expect(response_message['message']).to include(I18n.t 'translation_from_misprint_alert')
        end
      end
    end
  end
end
