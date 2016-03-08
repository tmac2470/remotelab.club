Rails.application.routes.draw do

  resources :rigs
  resources :laboratories
  resources :gateways

  get 'laboratories/:id/ui-designer', :to => 'laboratories#ui_designer', :as => 'ui_designer'

  get 'laboratories/:id/get_form/:type', :to => 'laboratories#get_form', :as => 'ui_designer_get_form'

  get 'r/:id', :to => 'rigs#r_session', :as => 'rig_session'

  get 'experiments', :to => 'rigs#experiments', :as => 'experiments'

  post 'mqtt', :to => 'gateways#mqtt_publish', :as => 'mqtt_publish'

  get 'api/get_chart_data', :to => 'rigs#get_chart_data', :as => 'get_chart_data'

  get 'api/get_log_data', :to => 'rigs#get_log_data', :as => 'get_log_data'

  #get 'laboratory/new', :to => 'laboratories#create', :as => 'laboratory'

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
