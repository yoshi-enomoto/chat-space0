FactoryGirl.define do

  factory :user do
    # 『rails c』で確認可能。
    password = Faker::Internet.password(8)
    # 引数は『min_length』の意味となる。
    # password(8,8)でminとmaxを指定でき、文字数を指定出来る。

    name      Faker::Name.name
    # 『.name』は他にも、last_nameやfirst_nameが使用可能。
    email     Faker::Internet.email
    # 『.email』は他にも、free_emailやsafe_email("xxx")などが使用可能。
    password  password
    password_confirmation  password
  end
end
