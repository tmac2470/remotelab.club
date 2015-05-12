Rails.application.routes.draw do
  resources :rigs

  get 'rigs/:id/ui-designer', :to => 'rigs#ui_designer', :as => 'ui_designer'

  get 'rigs/:id/get_form/:type', :to => 'rigs#get_form', :as => 'ui_designer_get_form'

  get 'r/:id', :to => 'rigs#r_session', :as => 'rig_session'

  post 'mqtt', :to => 'rigs#mqtt_publish', :as => 'mqtt_publish'

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
