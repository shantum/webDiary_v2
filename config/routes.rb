Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get '/user_links/new', to: 'user_links#new'
  get '/user_links/view/:id', to: 'user_links#view', as: 'user_link_view'
  get '/user_links/edit/:id', to: 'user_links#edit', as: 'user_link_edit'
  get '/user_links/index', to: 'user_links#index'
  get '/user_links/create', to: 'user_links#new'

  post '/user_links/create', to: 'user_links#create'
  post '/user_links/edit/:id', to: 'user_links#edit'
  post '/user_links/delete/:id', to: 'user_links#delete', as: 'user_link_delete'


end
