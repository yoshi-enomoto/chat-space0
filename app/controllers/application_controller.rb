class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 未ログイン時にログインページへ遷移する設定
  # 設定したいコントローラーに記述（今回は全てのページに適用させる為、ここ）
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # 下と1セット

  # # サインアウト後のリダイレクト先を設定
  # # 引数には『resource』を渡す（deviseのメソッドを上書きしている為）
  # # 返り値にリダイレクト先のURLを指定
  # def after_sign_out_path_for(resource)
  #   '/users/sign_in'
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  # devise_parameter_sanitizer.permit(追加したいメソッドの種類, keys: [追加したいパラメーター名])
  # 上と1セット

  end

end
