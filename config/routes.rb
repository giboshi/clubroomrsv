Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'circles#new'
  post 'reservations/new', to: 'reservations#create'
  resources :circles, only: [:index, :show, :new, :create] do#index,showは必要ないかも？
    member do
      get :reservations  #/circles/:id/reservations(.:format)   circles#reservations
      get :reserved_rooms#/circles/:id/reserved_rooms(.:format) circles#reserved_roomsこれが必要なのか不明
    end
  end
  resources :reservations, only: [:index, :new, :create, :destroy]
end
