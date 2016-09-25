module ApiFlashcards
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    private

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "password"
      end
    end
  end
end
