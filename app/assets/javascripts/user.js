$(function() {
  // htmlを差し込む要素名を変数定義
  var search_user = $("#user-search-result");

  function appendUser(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user.name}</p>
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
                </div>`
    search_user.append(html);
  }

  function appendNoUser(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user}</p>
                </div>`
    search_user.append(html);
  }

  // jqオブジェクトを変数定義
  var $input = $("#group_user-search-field");

  // 本処理ー『チャットメンバーを追加』エリアにユーザーの表示
  $input.on("keyup",function(){
    var input = $input.val();

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

  });

});
