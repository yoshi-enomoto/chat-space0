class UsersController < ApplicationController
  def index
    # moooviの応用。
    @users = User.where("name LIKE(?)", "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    # @user = User.find(params[:id]) ：『current_user』で引き出せるから不要
  end

  def update
    if current_user.update(user_params)
      # update()の括弧を記述しないと、引数の引き渡しエラーがまず発生する。
      # view側が1個に対して、controller側は0個となる為。
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
