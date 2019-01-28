require 'rails_helper'

RSpec.describe Coupon, type: :request do
  describe 'GET coupon' do
    it 'returns http success' do
      promotion = create(:promotion, name: 'Promo', discount: 10)
      coupon = create(:coupon, promotion: promotion, status: :available)
      coupon.update code: Coupon.generate_code(coupon.promotion.prefix)

      uri = "/api/v1/coupons/#{coupon.code}"
      get uri
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json['status']).to eq('available')
      expect(json['discount']).to eq('10.0')
      expect(json['promotion_name']).to eq('Promo')
    end

    it 'returns http success' do
      uri = '/api/v1/coupons/CodeInvalid'
      get uri
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:not_found)
      expect(json).to eq('Coupon does not exist')
    end
  end
end
