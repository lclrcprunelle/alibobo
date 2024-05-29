Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :products do
    resources :bookings, only: %i[new create edit update]

    collection do
      get 'myProducts'
    end
  end
  resources :bookings, only: :index
end
