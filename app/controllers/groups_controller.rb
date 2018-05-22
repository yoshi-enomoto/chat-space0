class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    # @group = Group.new(group_params)
    # @group.save
    # 上記２行は下記１行で賄える。
    Group.create(group_params)
    redirect_to root_path, notice: "グループ作成完了"
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
