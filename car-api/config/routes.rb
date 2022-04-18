Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'orders/create'
      get 'orders/index'
      get 'orders/show'
      get 'orders/destroy'
      get 'orders/update'
    end
  end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]
      resources :customers, only: %i[show create update destroy]
      resources :tokens, only: [:create]
      resources :products, only: %i[create update destroy show index]
      resources :orders, only: %i[create index show update destroy]
    end
  end
end
