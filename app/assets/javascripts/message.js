// ページ遷移後に非同期通信を適用させる為、記述変更。
// $(function(){
$(document).on('turbolinks:load', function() {
  // この位置に『$(function(){』を設置しないで問題無し（上記で賄う）
  // ビューに差し込むhtmlの関数
  function buildHTML(message) {
    // メッセージテキストの三項演算子
    var body = message.body ?`<p class="lower-message__content">
                                ${message.body}
                              </p>` :""

    // メッセージ画像の三項演算子
    var image = message.image ?`<img class="lower-message__iamge" src="${message.image}">` :""

    // 差し込む本体
    var html = `<div class="message">
                  <div class="upper-message">
                    <div class="upper-message__user-name">
                    ${message.user_name}
                    </div>
                    <div class="upper-message__date">
                    ${message.time}
                    </div>
                  </div>
                  <div class="lower-message">
                    ${body}
                    ${image}
                  </div>
                </div>`
    return html;
  }

  // メッセージ送信機能の非同期通信
  // 下記は指定した要素のみを取得
  // $(".form__submit").on("click", function(e) {
  // 下記は指定したform要素、中全てを取得=thisの利便性向上（ajax通信時に楽）
  $("#new_message").on("submit", function(e) {
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr("action");

    $.ajax({
      url: url,
      type: "post",
      data: formData,
      dataType: "json",
      processData: false,
      contentType: false
    })

    .done(function(data){
      // 通信成功時の処理確認
      // console.log("success!");
      // console.log(data);
      var html = buildHTML(data);
      $(".messages").append(html);
      // 下記１行で『.val("")』の2行を賄える。
      $("#new_message")[0].reset();
      // $(".form__message").val("");
      // $(".hidden").val("");
      // submitボタンに付加される『disabled』属性を消す（送信不可を解除する）
      $(".form__submit").removeAttr("disabled");
      // ？？？配列の0番目の要素のheight（padding込み）を取得し、？？？
      // 通常通り、速度、動作パターンを設定することは可能。
      $(".messages").animate({scrollTop: $(".messages")[0].scrollHeight}, 1000, "swing");

    })

    .fail(function(){
      alert("通信に失敗しました")

    })
  });

  // メッセージの自動更新
  var interval = setInterval(update, 5000);
  // ページ遷移時、最新までスクロールさせる為に追加。
  $(".messages").animate({scrollTop: $(".messages")[0].scrollHeight}, 1000, "swing");

  // 自動更新用の関数
  function update() {
    // 条件分岐確認の為のコンソール
    // console.log(location.href);
    // console.log(location);
    // console.log(window.location);
    // var x = window.location.href.split("/");
    // console.log(x);
    // var y = x[3] + x[4] + x[5]
    // console.log(y);

    // メッセージ画面のURL一致の条件分岐
    if (location.href.match(/\/groups\/\d+\/messages/)){
    // 『/\/groups\/\d+\/messages/』について
    // 実質、『\/groups\/\d+\/messages』
    // 『\』はエスケープ（特殊記号を通常の記号文字として使用する意味）
    //『\d』は数字、『+』は付加した文字の1文字以上の繰り返しを意味する。
    // ->つまり、数字の繰り返し（2桁でも3桁でもOK）
      // フロー確認用
      // console.log(true);
      $.ajax({
        url: location.href,
        type: "get",
        dataType: "json"
        // 『data:』など、送るデータが無ければ設ける必要無し。
      })
      .done(function(data) {
      })
      .fail(function() {
        alert("更新に失敗しました。");
      });
    } else {
      clearInterval(interval);
      // フロー確認用
      // console.log(false);
    }
  }

});
