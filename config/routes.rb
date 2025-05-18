Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about', to: 'homes#about'
    get "search", to: "searches#search"
    get 'likes', to: 'likes#index', as: 'liked_posts'

    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :like, only: [:create, :destroy] 
    end

    resources :lost_pets do
      resources :lost_pet_comments, only: [:index, :create, :destroy]
    end

    resources :users, only: [:show, :edit, :update, :destroy]
    
  end

  namespace :admin do
    root to: 'users#index'
    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end
end
