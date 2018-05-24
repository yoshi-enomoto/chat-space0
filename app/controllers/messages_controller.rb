class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @group = Group.find(params[:group_id])

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
end
