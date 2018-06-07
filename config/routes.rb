Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'  #『root』を設定する場合は『コントローラー#アクション』
  resources :users, only: [:edit, :update, :index]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
    # resources :messages, only: [:new, :create]
    # 『index』でメッセージ入力も出来るので上1行は間違い（newだと、一覧表示は違う）
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
