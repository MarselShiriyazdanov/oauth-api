FactoryGirl.define do
  factory :user do
    email
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password "123456"
    password_confirmation { password }
    confirmed_at 1.hour.ago
  end

  trait :not_confirmed do
    confirmed_at nil

    after(:create) do |user|
      user.update(confirmation_sent_at: 3.days.ago)
    end
  end

  trait :from_auth_hashie do
    email "joe@bloggs.com"
  end
end
