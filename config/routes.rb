Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: :index
  resource :csv_upload, only: %i[new create]
end
