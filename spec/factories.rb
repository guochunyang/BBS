FactoryGirl.define do
  factory :user do
    username 'haha'
    email 'test@test.com'
    password 'helloworld'
    password_confirmation 'helloworld'
  end
end