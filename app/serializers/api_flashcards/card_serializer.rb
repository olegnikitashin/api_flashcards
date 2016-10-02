require "active_model_serializers"
module ApiFlashcards
  class CardSerializer < ActiveModel::Serializer
    attributes :original_text , :translated_text, :review_date, :id
  end
end
