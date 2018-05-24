Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'  #『root』を設定する場合は『コントローラー#アクション』
  resources :users, only: [:edit, :update]
  resources :groups, only: [:new, :create, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
