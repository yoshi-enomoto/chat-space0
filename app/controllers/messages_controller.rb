class MessagesController < ApplicationController
  before_action :set_group

  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
    # アソシエーションにより、該当グループに関連するメッセージのみが取得可能。
    # ユーザーのレコード取得時に限り、N+1問題が発生しそう？
    # pictweet時もユーザー関連で、今回も『group』や『message』ではなく『:user』としている
      # @messages = Message.all
      # 上記の記述では、グループに関係なく全てのメッセージを取得してしまう。
  end

  def create
    @message = Message.new(message_params)
    # @message = @group.messages.new(message_params) 模範解答での記述
    # 『@group.message』ではエラーとなる。
    # 『@group.messages』で該当グループに関連するメッセージが取得可能。
    # 『~es.new』とすることで、単体用のインスタンスが生成可能。

    if @message.save
      redirect_to group_messages_path(@group), notice: "メッセージ送信完了"
    else
      # 『flash』は記述の順番が重要（後に記述すると表示されない）
      flash.now[:alert] = "メッセージを入力してください。"
      # 『.now』は『render』の際に使用。
      # 現在のリクエストのみ有効。次のリクエストになると削除される。
        # flash[:alert] = "メッセージは入力しましたか？"
        # 『.now』無しは『redirect_to』の際に使用。
        # 次のリクエストまで有効。その次のリクエストになると削除される。
        #    無しを試す場合、『flash』が表示されないリクエスト（グループ編集orユーザー編集）
        #    などに遷移してみれば、意味がわかる。

      @messages = @group.messages.includes(:user)
      render :index
      # 『render』は、ビューの描写のみ。
      # （その該当アクションは通らないので、インスタンス変数などを参照しない）
      # なので、『render』前に『@messages』を記述する。
      # その記述順序が逆だと参照されない。
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
