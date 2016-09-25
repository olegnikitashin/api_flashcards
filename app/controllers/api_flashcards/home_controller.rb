require_dependency "api_flashcards/application_controller"

module ApiFlashcards
  class HomeController < ApplicationController
    before_action :basic_auth

    def index
    end
  end
end
