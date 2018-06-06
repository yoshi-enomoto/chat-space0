$(function() {
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

  });

});
