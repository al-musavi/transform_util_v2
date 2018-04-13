Rails.application.routes.draw do
  root :to => "home#index"
  resources :compares
  resources :dest_fields do 
    resources :ref_field_sources
  end
  resources :home
  resources :inputs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
