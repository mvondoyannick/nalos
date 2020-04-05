Rails.application.routes.draw do
  resources :salle_de_classes
  resources :cycles
  resources :enseignements
  resources :structures
  # get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
