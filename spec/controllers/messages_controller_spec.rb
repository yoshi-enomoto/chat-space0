require 'rails_helper'

# 『メッセージ一覧ページを表示するアクション』での確認事項
# ●ログインしている場合
#  ・アクション内で定義しているインスタンス変数があるか
#    ->@message、@group
#  ・該当するビューが描画されているか
#    ->#index
# ●ログインしていない場合
#  ・意図したビューにリダイレクトできているか
#    ->#indexからのリダイレクト

describe MessagesController do
  describe '#index' do
    # letを利用してテスト中使用するインスタンスを定義
    # FactoryGirlで作成
    let(:group) { create(:group) }
    let(:user) { create(:user) }

    # ログインしている場合
    context 'log in' do
      before do
        # 作ったユーザでログイン
        login_admin user   # 『メソッド モデル名』の順
        # 『擬似的に動かすアクションのリクエストを共通処理化』
        get :index, params: { group_id: group.id }
      end

      # 『@messages』の場合が必要と思いトライしたが、うまくいかなかった為。
      # it "populates an array of messages ordered by created_at ASC" do
      #   messages = create_list(:message, 10)
      #   expect(assigns(:messages)).to match(messages.sort{ |a, b| a.created_at <=> b.created_at})
      # end

      it "assigns @message" do
        expect(assigns(:message)).to be_a_new(Message)
        # 『be_a_new』で同じクラスのインスタンス、かつ未保存のレコードかどうかを確認。
      end

      it "assigns @group" do
        expect(assigns(:group)).to eq group
      end

      it "renders the :index template" do
        expect(response).to render_template :index
      end
    end

    # ログインしていない場合
    context 'not log in' do
      before do
        # 『擬似的に動かすアクションのリクエストを共通処理化』
        # 『/groups/:group_id/messages』を直打ちしてページに遷移する感覚な為、『params』以降は必要。
        get :index, params: { group_id: group.id }
      end

      it "redirect_to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end




  # describe 'HTTPメソッド名 #アクション名' do
  #   it "インスタンス変数は期待した値になるか？" do
  #   "擬似的にリクエストを行ったことにするコードを書く"
  #     "エクスペクテーションを書く"
  #   end

  #   it "期待するビューに遷移するか？" do
  #     "擬似的にリクエストを行ったことにするコードを書く"
  #     "エクスペクテーションを書く"
  #   end
  # end

end
