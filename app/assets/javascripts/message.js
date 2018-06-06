$(function(){
  // 下記は指定した要素のみを取得
  // $(".form__submit").on("click", function(e) {
  // 下記は指定したform要素、中全てを取得=thisの利便性向上（ajax通信時に楽）
  $("#new_message").on("submit", function(e) {
    e.preventDefault();
    console.log(this);

  });
});
