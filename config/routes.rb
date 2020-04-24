Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :tasks, only: %i[new create edit update destroy] do
    patch 'change-priority', to: 'tasks#change_priority', on: :member
  end
end
