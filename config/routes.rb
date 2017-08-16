Rails.application.routes.draw do
  root to: 'tasklists#index'
  
  resources :tasklists
end
