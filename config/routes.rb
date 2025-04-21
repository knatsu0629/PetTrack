Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: [:show, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get '/about', to: 'homes#about'

  resources :posts
  resources :lost_pets
end

