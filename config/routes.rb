SpWebapp::Application.routes.draw do

  resources :dxes

  root :to => 'sessions#new'
  
  resources :users
  match '/signup',  to: 'users#new', via: [:get, :post]
  match '/profile', to: 'users#show', via: [:get]
  match '/dashboard/disorders/search', to: 'users#search_disorders', via: [:get]
  match '/dashboard/disorders/:cui', to: 'users#find_a_disorder', via: [:get]
  match '/treatments/search', to: 'users#search_treatments', via: [:get]
  match '/prescriptions/:cui', to: 'users#find_prescriptions_for_disorder', via: [:get]
  match '/prescriptions', to: 'users#add_prescription', via: [:post]

  resources :disorders
  match 'disorders', to: "disorders#index", via: [:get, :post]

  resources :sessions, only: [:new, :create, :destroy]
  match '/login',  to: 'sessions#new', via: [:post]
  match '/logout', to: 'sessions#destroy', via: [:delete]

  match '/dashboard', to: 'cms#index', via: [:get]
end
