Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]
      resources :customers, only: %i[show create update destroy]
      resources :tokens, only: [:create]
      resources :products, only: %i[create update destroy show index]
    end
  end
end
