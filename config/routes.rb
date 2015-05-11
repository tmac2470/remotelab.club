Rails.application.routes.draw do
  resources :rigs

  get 'rigs/:id/ui-designer', :to => 'rigs#ui_designer', :as => 'ui_designer'

  get 'rigs/:id/get_form/:type', :to => 'rigs#get_form', :as => 'ui_designer_get_form'

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
