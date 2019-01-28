FactoryBot.define do
  factory :promotion do
    description { Faker::Lorem.characters(15) }
    discount { Faker::Number.between(1, 100) }
    name { Faker::Lorem.characters(10) }
    days { Faker::Number.number(3) }
    coupon_limit { 100 }
    prefix { 'MAIL12' }
    start_at { Time.zone.today }
    status { 0 }
    creation_user
    product

    trait :approved do
      status { 1 }
      activated_at { Time.zone.today }

      transient do
        approval_user { create(:user) }
      end

      after(:create) do |promotion, evaluator|
        create(:promotion_approval, promotion: promotion,
                                    user: evaluator.approval_user)
      end
    end
  end
end
