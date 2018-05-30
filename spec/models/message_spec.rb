require "rails_helper"

# 自己解答
describe Message do
  describe "#create" do
  # メッセージを保存できる場合
    # メッセージがあれば保存できる
    it "is valid with all except no-image" do
      message = build(:message, image: "")
      expect(message).to be_valid
    end

    # 画像があれば保存できる
    it "is valid with all except no-body" do
      message = build(:message, body: "")
      expect(message).to be_valid
    end

    # メッセージと画像があれば保存できる
    it "is valid with all" do
      message = build(:message)
      expect(message).to be_valid
    end

  # メッセージを保存できない場合
    # メッセージも画像も無いと保存できない
    it "is invalid with both of them(body, image)" do
      message = build(:message, body: "", image: "")
      message.valid?
      expect(message.errors[:body]).to include("を入力してください")
    end

    # group_idが無いと保存できない
    it "is invalid with group_id" do
      message = build(:message, group_id: "")
      message.valid?
      expect(message.errors[:group]).to include("を入力してください")
    end

    # user_idが無いと保存できない
    it "is invalid with both of them(body, image)" do
      message = build(:message, user_id: "")
      message.valid?
      expect(message.errors[:user]).to include("を入力してください")
    end
  end
end

# 模範解答
# RSpec.describe Message, type: :model do
#   describe '#create' do
#     context 'can save' do
#       it 'is valid with content' do
#         expect(build(:message, image: nil)).to be_valid
#       end

#       it 'is valid with image' do
#         expect(build(:message, content: nil)).to be_valid
#       end

#       it 'is valid with content and image' do
#         expect(build(:message)).to be_valid
#       end
#     end

#     context 'can not save' do
#       it 'is invalid without content and image' do
#         message = build(:message, content: nil, image: nil)
#         message.valid?
#         expect(message.errors[:content]).to include('を入力してください')
#       end

#       it 'is invalid without group_id' do
#         message = build(:message, group_id: nil)
#         message.valid?
#         expect(message.errors[:group]).to include('を入力してください')
#       end

#       it 'is invaid without user_id' do
#         message = build(:message, user_id: nil)
#         message.valid?
#         expect(message.errors[:user]).to include('を入力してください')
#       end
#     end
#   end
# end
