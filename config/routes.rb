ApiFlashcards::Engine.routes.draw do
  root to: 'home#index'

  scope module: 'api' do
    namespace :v1 do
      get :cards, to: 'cards#index'
      # resources :cards
    end
  end
end
