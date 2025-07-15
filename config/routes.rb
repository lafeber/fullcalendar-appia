Rails.application.routes.draw do
  resources :events
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get :groupcare_events, to: "external_events#groupcare"
  get :agenda_events, to: "external_events#agenda"
  get :moves_events, to: "external_events#moves"
  get :presence_log_events, to: "external_events#presence_logs"

  # Defines the root path route ("/")
  root "events#index"
end
