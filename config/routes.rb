Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :products do
    resources :bookings, only: %i[new create edit update]
    resources :reviews, only: [:new, :create]

    collection do
      get 'myProducts'
    end
  end

  resources :alerts, only: :index

  resources :bookings, only: :index do
    member do
      patch :accept
      patch :decline
    end
  end

end
