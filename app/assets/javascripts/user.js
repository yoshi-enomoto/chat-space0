$(function() {
  // jqオブジェクトを変数定義
  var $input = $("#group_user-search-field");

  // 本処理ー『チャットメンバーを追加』エリアにユーザーの表示
  $input.on("keyup",function(){
    var input = $input.val();
  });

});
