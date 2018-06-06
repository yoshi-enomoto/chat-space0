# json形式のデータを配列で返す場合の記述法（複数形）
json.array! @users do |user|
  json.id user.id
  json.name user.name
end
