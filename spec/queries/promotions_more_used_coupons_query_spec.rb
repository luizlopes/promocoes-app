require 'rails_helper'

describe PromotionsMoreUsedCouponsQuery do

  it 'queries 5 promotions with more coupons' do
    promotion = create(:promotion)
    create_list(:coupon, 5, promotion: promotion)

    other_promotion = create(:promotion)
    create_list(:coupon, 10, promotion: other_promotion)

    promotions = []
    promotions << other_promotion
    promotions << promotion

    expect(PromotionsMoreUsedCouponsQuery.call).to match promotions
  end
end
