require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it 'is valid with valid attributes' do
    coupon = create(:coupon)
    coupon.update code: Coupon.generate_code(coupon.promotion.prefix)
    expect(coupon).to be_available
  end

  it 'is not valid' do
    coupon = create(:coupon)
    coupon.update code: Coupon.generate_code(coupon.promotion.prefix)
    coupon.create_usage
    expect(coupon).to be_unavailable
  end
end
