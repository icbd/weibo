Rails.application.routes.draw do
  root 'static_pages#home'

  # 静态页面
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  # 注册
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: "login#new"
  post '/login', to: "login#create"
  delete '/logout', to: "login#destroy"

  resources :users

  resource :account_activations, only: [:edit]
end

