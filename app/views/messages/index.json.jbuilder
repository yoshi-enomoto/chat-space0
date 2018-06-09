# 『キーとバリューで渡す場合』
# json.text "バリュー値"
# ->{"text": "バリュー値"}

# 『json』の後の『.~~』がキーorメソッド.
# 『array!』の場合は、配列を返すメソッド。

# 『.each』は無くても問題ない。
json.messages @messages do |message|
# 下記にする場合、受ける側の記述を変えれば可能。
# json.array! @messages do |message|
  json.id message.id
  json.body  message.body
  json.image  message.image.url
  json.user_name  message.user.name
  json.time  format_posted_time(message.created_at)
end
