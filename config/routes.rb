Rails.application.routes.draw do
  resources :rooms do
    resources :messages, only: [:create, :destroy]
  end
  root 'pages#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
