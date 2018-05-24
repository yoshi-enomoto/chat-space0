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

    if @message.save
      redirect_to group_messages_path(@group), notice: "メッセージ送信完了"
    else
      render :index, alert: "メッセージ送信失敗"
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
