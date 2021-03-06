Rails.application.routes.draw do
  get '/search' => 'search#search'
  devise_for :users

  root to: 'homes#top'
  get 'users' => 'users#index'
  get 'home/about' => 'homes#about'

  resources :books do

   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update]

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

  get 'followings/:id' => 'users#followings', as: 'followings' #フォローしているユーザ一覧
  get 'follows/:id' => 'users#follows', as: 'follows' #フォローされているユーザ一覧

end
