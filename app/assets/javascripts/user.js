// ページ遷移後に非同期通信を適用させる為、記述変更。
// 記述を変更させない場合、『turblinks』を削除する必要あり。
$(document).on('turbolinks:load', function() {
// $(function() {
  // htmlを差し込む要素名を変数定義
  var search_user = $("#user-search-result");

  // 検索結果に差し込むhtml（結果ありver）
  function appendUser(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user.name}</p>
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
                </div>`
    search_user.append(html);
  }
  // 検索結果に差し込むhtml（結果なしver）
  function appendNoUser(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user}</p>
                </div>`
    search_user.append(html);
  }

  // jqオブジェクトを変数定義
  var $input = $("#user-search-field");

  // 本処理『チャットメンバーを追加』エリアにユーザーの表示(検索結果)
  $input.on("keyup",function(){
    var input = $input.val();

    // 文字列以外の入力で検索結果が表示されないようにする
    if (input.length !== 0){
      $.ajax({
        type: "get",
        // 『url』には入力内容の保存先ではなく、検索をする元になるインスタンス変数があるアクションを動かすurlを指定する。
        url: "/users",
        data: { keyword: input },
        dataType: "json"
      })

      .done(function(users) {
        search_user.empty();

        if (users.length !== 0){
          users.forEach(function(user){
            appendUser(user);
          });
        }
        else {
          appendNoUser("一致するユーザーはいません");
        }
      })
      .fail(function() {
        alert("ユーザー検索に失敗しました。");
      })
    }

  });

  //『チャットメンバー』エリアへ差し込むhtml
  var $add_user = $("#chat-group-users");

  function addUser(userid, username) {
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-${userid}'>
                  <input name='group[user_ids][]' type='hidden' value='${userid}'>
                  <p class='chat-group-user__name'>${username}</p>
                  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
                </div>`

    $add_user.append(html);
    // $("#chat-group-users").append(html);
  }

  // 本処理『チャットメンバーを追加』エリアの追加ボタン
  $(document).on("click", ".user-search-add", function() {
    // 『document』と『window』について、中身・詳細確認の為
    // console.log(document);
    // console.log(window);

    // このタイミングで変数に代入して、関数呼び出し時に引数で渡し、関数内で使用可能。
    // ２つの違いは？
    var userid = $(this).attr("data-user-id");
    // var userid = $(this).data("user-id");
    var username = $(this).attr("data-user-name");
    // var username = $(this).data("user-name");

    // 検索一覧から追加したユーザーの削除
    $(this).parent().remove();
    // 『チャットメンバー』エリアへのユーザー追加
    addUser(userid, username);
  });

});
