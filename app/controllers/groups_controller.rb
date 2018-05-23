class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    # Group.create(group_params)
    # 下記aとbは上記１行で賄える。
    @group = Group.new(group_params) #『a』
    # 『@group.user_ids』でグループ作成時に加えたuser_idが取得可能。

    if @group.save #『b』
      redirect_to root_path, notice: "グループ作成完了"
    else
      render :new
    end
    # 流れ：params内のpermitのみをDBへ保存 → redirectさせる、かつflashを『notice』キーで表示させる。
    # グループ作成の過程中、『notice、alert』以外のキー指定では表示不可（原因不明）
  end

  def edit
  end

  def update
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end
end
