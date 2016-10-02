ApiFlashcards::Engine.routes.draw do
  # apipie
  root to: 'api/v1/cards#index'

  scope module: 'api' do
    namespace :v1 do
      get  :cards,  to: 'cards#index'
      post :cards,  to: 'cards#create'
      get :trainer, to: 'trainer#index'
      put :trainer, to: 'trainer#review_card'
    end
  end
end
