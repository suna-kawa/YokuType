Rails.application.routes.draw do
  root 'users#index'
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, only: [:update]
  get 'users/profile'
  get 'users/mypage'
end
