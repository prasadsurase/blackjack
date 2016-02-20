Rails.application.routes.draw do
  root to: 'games#index'

  resources :games, only: [:index, :new, :create, :show] do
    member do
      put :hit
      put :stand
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
