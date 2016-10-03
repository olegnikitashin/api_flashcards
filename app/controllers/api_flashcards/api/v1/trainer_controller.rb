module ApiFlashcards
  module Api::V1
    class TrainerController < ApiFlashcards::ApplicationController

      api :GET, '/v1/trainer', 'Returns a pending card to review'
      param :id, Integer, desc: 'Card id for card devision'
      def index
        if params[:id]
          @card = current_user.cards.find(params[:id])
        else
          @card = current_user.cards.pending.first
          @card ||= current_user.cards.repeating.first
        end

        render json: @card, serializer: CardSerializer
      end

      api :PUT, 'v1/trainer', 'Puts data for card revision'
      param :card_id, String, desc: 'Card_id to find card', required: true
      param :user_translation, String, desc: 'User input for translation'
      def review_card
        @card = current_user.cards.find(params[:card_id])
        check_result = @card.check_translation(trainer_params[:user_translation])

        if check_result[:state]
          if check_result[:distance] == 0
            render json: { message:  t(:correct_translation_notice)}, status: 200
          else
            render json: { message: ( t 'translation_from_misprint_alert',
                              user_translation: trainer_params[:user_translation],
                              original_text: @card.original_text,
                              translated_text: @card.translated_text)
                              },
                              status: 200
          end
        else
          render json: { message: t(:incorrect_translation_alert) }, status: 200
        end
      end

      private

      def trainer_params
        params.permit(:user_translation)
      end
    end
  end
end
