Rails.application.routes.draw do
  namespace :accounts do
    resources :organizations
  end
  mount RailsPgExtras::Web::Engine, at: "pg_extras"
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  post "/graphql", to: "graphql#execute"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get "/oauth/keycloak", to: "oauth#new", as: "oauth_login"
  get "/oauth/:provider/callback", to: "oauth#create"
  get "/oauth/failure", to: "oauth#failure"
  get "/", to: "oauth#new"
  # Defines the root path route ("/")
  root "organizations#index"
  namespace :api, defaults: { format: :json } do
    namespace :app do
      resources :info, only: [ :index ]
    end
  end
  scope :api, as: :api, defaults: { format: :json } do
    namespace :accounts do
      resources "organizations"
    end
  end
end
