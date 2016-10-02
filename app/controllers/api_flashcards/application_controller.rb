require "active_model_serializers"

module ApiFlashcards
  class ApplicationController < ActionController::Base
    protect_from_forgery
    include ActionController::Serialization
    attr_reader :current_user
    before_action :basic_auth

    private

    def basic_auth
      authenticate_or_request_with_http_basic do |email, password|
        auth = User.where(email: email).first
        if auth
          @current_user = auth
        else
          render json: { message: "Authentication failed" }, status: 401
        end
      end
    end
  end
end
