# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'posts#index'

  resources :posts do
    resources :comments, only: %i[new edit create update destroy]
  end

  resources :users, only: %i[index] do
    member do
      post :follow
      delete :unfollow
    end
  end
end
