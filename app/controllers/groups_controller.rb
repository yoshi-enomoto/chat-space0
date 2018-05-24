class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]

  def new
    @group = Group.new
    @group.users << current_user
    # 『@group.users』は配列になる。
      # @user = User.all
      # @user =[] << User.find(2)
      # 『collection_check_boxes』の第2引数（リスト一覧）は配列を展開表示しているみたいなので、『[] << ~~ 』で個別指定も可能。
  end

  def create
    # Group.create(group_params)
    # 下記aとbは、上記１行で賄える。
    @group = Group.new(group_params) #『a』
    # 『@group.user_ids』でグループ作成時に加えたuser_idが取得可能。

    if @group.save #『b』
      # redirect_to root_path, notice: "グループ作成完了"：初期作成時の設定
      redirect_to group_messages_path(@group), notice: "グループ作成完了"
      # モデルを引数として渡すと、そのモデルはIDに変換される=『id』を渡すでも問題無し。
      # 『@group』なら、前述で定義している。『group』は定義していないので、不可。
    else
      render :new
    end
    # 流れ：params内のpermitのみをDBへ保存 → redirectさせる、かつflashを『notice』キーで表示させる。
    # グループ作成の過程中、『notice、alert』以外のキー指定では表示不可（原因不明）
  end

  # def edit 『set_group』により、このアクションで定義することがなくなるので、コメアウト
  #   # @group = Group.find(params[:id]) 『set_group』により、コメアウト
  # end

  def update
    # @group = Group.find(params[:id]) 『set_group』により、コメアウト
    if @group.update(group_params)
    #『update』メソッド時、どれに対して更新させるか引数を与えてやる。
      # redirect_to root_path, notice: "グループ更新完了"：初期作成時の設定
      redirect_to group_messages_path(@group.id), notice: "グループ更新完了"
    else
      render :edit
    end
  end

  private
  def group_params
    # params.require(:group).permit(:name)：中間テーブルに保存させる前のparamsの仕様
    params.require(:group).permit(:name, user_ids: [])
    # 中間テーブルへの保存は『user_ids: []』の記述を追加する。（配列のパラメータ）
      # 今回、memberテーブルへレコード保存時、『group_id』が入力出来ないエラーが発生。
      # →テーブルの仕様『null:false』を削除することで回避。
      # 旧chat-spaceではその仕様を削除せずにmemberテーブルへレコード保存出来たので、今回この様になってしまった理由が気になるところ。
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
