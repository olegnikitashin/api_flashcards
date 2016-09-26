module ApiFlashcards
  module Api::V1
    class CardsController < ApiFlashcards::ApplicationController

      def index
        @cards = current_user.cards.all.order('review_date')
        render json: @cards, status: 200
      end

      def create
        render json: 'Success', status: 200
      end
    end
  end
end
