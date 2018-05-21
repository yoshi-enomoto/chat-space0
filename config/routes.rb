Rails.application.routes.draw do
  root 'messages#index'  #『root』を設定する場合は『コントローラー#アクション』

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
