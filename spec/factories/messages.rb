FactoryGirl.define do

  factory :message do
    body  Faker::Lorem.sentence
    image File.open("#{Rails.root}/public/images/sample.jpg")
    # 実際に上記の配下にサンプル画像を配置して読み込む。
    user
    group
  end
end
