module ControllerMacros
  # loginメソッドの定義
  def login_admin(admin)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in admin
  end

end
