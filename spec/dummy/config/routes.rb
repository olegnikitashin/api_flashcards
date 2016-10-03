Rails.application.routes.draw do
  mount ApiFlashcards::Engine => "/api_flashcards"
  apipie
end
