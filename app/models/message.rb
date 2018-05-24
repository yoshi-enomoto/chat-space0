class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :body, presence: true, unless: :image?
  # テキストメッセージ自体のバリデート（但し、画像も無い場合のみ、発動）
end
