require 'rails_helper'
  # describe 'HTTPメソッド名 #アクション名' do
  #   it "インスタンス変数は期待した値になるか？" do
  #     "擬似的にリクエストを行ったことにするコードを書く"
  #     "エクスペクテーションを書く"
  #   end

  #   it "期待するビューに遷移するか？" do
  #     "擬似的にリクエストを行ったことにするコードを書く"
  #     "エクスペクテーションを書く"
  #   end
  # end

describe MessagesController do
  # letを利用してテスト中使用するインスタンスを定義
  # テスト中＆『index』と『create』で適用させたいので、ここに書く。
  # FactoryGirlで作成
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  # 『メッセージ一覧ページを表示するアクション』での確認事項
  # ●ログインしている場合
  #  ・アクション内で定義しているインスタンス変数があるか
  #    ->@message、@group
  #  ・該当するビューが描画されているか
  #    ->#index
  # ●ログインしていない場合
  #  ・意図したビューにリダイレクトできているか
  #    ->#indexからのリダイレクト
  describe '#index' do
    # ●ログインしている場合
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

    # ●ログインしていない場合
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

  # 『メッセージ作成するアクション』での確認事項
  # ●ログインしているかつ、保存に成功した場合
  #  ・メッセージの保存はできたのか
  #  ・意図した画面に遷移しているか
  # ●ログインしているが、保存に失敗した場合
  #  ・メッセージの保存は行われなかったか
  #  ・意図したビューが描画されているか
  # ●ログインしていない場合
  #  ・意図した画面にリダイレクトできているか
  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }
    # 『create』を擬似的に動かす際に引数として渡す為、『params』を定義
    # 『attirbutes_for』：オブジェクトを生成せずにハッシュを生成する。

    # ●ログインしている、
    context "log in" do
      before do
        login_admin user
        # 『#index』テストとは異なり、擬似的にアクションを動かす記述は不要。
        # ここに『index』が無くて問題無い。
      end

      # ●かつ、保存に成功した場合
      context "can save" do
        # expectの引数の切り出し
        subject {
          post :create,
          params: params
        }

        it "count up message" do
          expect{ subject }.to change(Message, :count).by(1)
          #「postメソッドでcreateアクションを擬似的にリクエストをした結果」の意味
          # マッチャに『期待値』：レコードの総数が1個増えたかを確かめる。
        end

        it "redirects to group_messages_path" do
          subject
          # 『post :create』の記述で擬似的に動かすアクションのリクエストとなる。
          # 同時に、『params: params』が渡すパラメータ（引数）部分である。
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      # ●かつ、保存に失敗した場合
      context "can't save" do
        # エラーが起こるparamsの作成
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, body: nil, image: nil) } }

        # 上記で設定したparamsを渡す
        subject {
          post :create,
          params: invalid_params
        }

        it "doesn't count up" do
          expect{ subject }.not_to change(Message, :count)
          # 『.not_to』は『.to』の真逆（〜でないこと。の意）
        end

        it "renders the :index template" do
          subject
          expect(response).to render_template :index
        end
      end
    end

    # ●ログインしていない場合
    context "not log in" do
      it "redirect_to new_user_session_path" do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
