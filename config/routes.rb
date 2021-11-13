Rails.application.routes.draw do
  resources :properties, only: [:index]

  root 'properties#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
