module ApiFlashcards
  module Api::V1
    class CardsController < ApiFlashcards::ApplicationController
      
      api :GET, '/v1/cards', 'Returns all user cards'
      def index
        @cards = current_user.cards.all.order('review_date')
        render json: @cards, each_serializer: CardSerializer
      end

      api :POST, '/v1/cards', 'Creates new card'
      def create
        @card = current_user.cards.build(card_params)
        if @card.save
          render json: @card, each_serializer: CardSerializer
        else
          render body: nil, status: 400
        end
      end

      private

      def card_params
        params.require(:card).permit(:original_text, :translated_text,
                                     :block_id)
      end
    end
  end
end
