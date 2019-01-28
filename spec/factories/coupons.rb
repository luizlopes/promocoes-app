FactoryBot.define do
  factory :coupon do
    status { 0 }
    user
    promotion
  end
end
