module ApiFlashcards
  module Api::V1
    class CardsController < ApiFlashcards::ApplicationController

      def index
        render json: 'Success', status: 200
      end

    end
  end
end
