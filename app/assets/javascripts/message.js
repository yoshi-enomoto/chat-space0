$(function(){

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
      var html = buildHTML(data);
      $(".messages").append(html);
      $(".form__message").val("");
      $(".hidden").val("");

    })

    .fail(function(){
      alert("通信に失敗しました")

    })
  });
});
