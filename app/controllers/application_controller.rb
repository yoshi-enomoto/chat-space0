class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 未ログイン時にログインページへ遷移する設定
  # 設定したいコントローラーに記述（今回は全てのページに適用させる為、ここ）
  before_action :authenticate_user!

  # before_action :configure_permitted_parameters, if: :devise_controller?
  # 『devise_parameter_sanitizer』メソッドはDeviseのコントローラ以外で使用不可。
  # （deviseで追加されたメソッドの為）
  # すべてのコントローラがApplicationControllerを継承している為、
  # すべてのコントローラのアクションの前で『devise_parameter_sanitizer』メソッドが呼び出されてしまう。

  # # サインアウト後のリダイレクト先を設定
  # # 引数には『resource』を渡す（deviseのメソッドを上書きしている為）
  # # 返り値にリダイレクト先のURLを指定
  # def after_sign_out_path_for(resource)
  #   '/users/sign_in'
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  # devise_parameter_sanitizer.permit(追加したいメソッドの種類, keys: [追加したいパラメーター名])

  end

end
