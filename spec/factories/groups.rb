FactoryGirl.define do

  factory :group do
    name  Faker::Team.name #『Faker』により、自動生成
    # 『Faker::xxx.name』：xxxに作成したい分野的なのを入れる。
  end
end
