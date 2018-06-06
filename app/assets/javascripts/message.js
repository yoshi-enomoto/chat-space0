$(function(){

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
      $(".form__message").val("");
      $(".hidden").val("");
      // submitボタンに付加される『disabled』属性を消す（送信不可を解除する）
      $(".form__submit").removeAttr("disabled");

    })

    .fail(function(){
      alert("通信に失敗しました")

    })
  });
});
