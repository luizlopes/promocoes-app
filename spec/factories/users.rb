FactoryBot.define do
  factory :user, aliases: [:creation_user] do
    sequence :name do |n|
      "#{Faker::Name.name}#{n}"
    end
    sequence :email do |n|
      "#{n}#{Faker::Internet.email}"
    end
    password { '123456' }
    password_confirmation { '123456' }

    trait :admin do
      admin { true }
    end
  end
end
