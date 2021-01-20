Rails.application.routes.draw do
  resources :clients

  get "/uf/:date", to: 'clients#consult_uf'
  get "/client/:name", to: 'clients#my_queries'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
