Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create update destroy index]
      resources :customers, only: %i[show index create update destroy]
      resources :tokens, only: [:create]
      resources :products, only: %i[create update destroy show index]
      resources :orders, only: %i[create index show update destroy]
    end
  end
end
