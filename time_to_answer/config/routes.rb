Rails.application.routes.draw do
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :site do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index' #Dashbord
    #get 'admins/index'
    #get 'admins/edit/:id', to: 'admins#edit'
    #get 'admins/update/:id', to: 'admins#update'
    resources :admins, only: [:index, :edit, :update] # Admins
  end
  devise_for :admins
  devise_for :users
  
  get 'inicio', to: 'site/welcome#index'
  get 'admin', to: 'admins_backoffice/welcome#index'
  get 'user', to: 'users_backoffice/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'site/welcome#index'
end
