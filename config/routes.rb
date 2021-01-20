Rails.application.routes.draw do
  resources :clients
  get "/uf/:date", to: 'clients#consult_uf'
  get "/client/:name", to: 'clients#my_queries'
end
