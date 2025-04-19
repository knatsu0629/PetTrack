Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  resources :users, only: [:show, :edit, :update, :destroy] do
    collection do
      get 'search'
      post 'guest_sign_in'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get '/about', to: 'homes#about'

  resources :posts
end