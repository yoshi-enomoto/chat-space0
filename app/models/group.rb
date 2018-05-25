class Group < ApplicationRecord
  has_many :users, through: :members
  has_many :members
  has_many :messages

  validates :name, presence: true

  def show_last_message
    if (last_message = messages.last).present?
      last_message.body? ? last_message.body : '画像が投稿されています'
      # 条件式 ? trueの時の値 : falseの時の値 （三項演算子の書き方）
    else
      'まだメッセージはありません。'
    end
  end

=begin
  ・三項演算子は下記の様に書き換え可能。

  def show_last_message
    if (last_message = messages.last).present?
      if last_message.body? # 『.body?』とすることで『.present?』を省いて書ける。
        last_message.body
      else
        "画像が投稿されています"
      end
    else
      "まだメッセはないよん♪"
    end
  end
=end
end
