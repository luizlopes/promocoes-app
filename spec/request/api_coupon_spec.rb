require 'rails_helper'

RSpec.describe Coupon, type: :request do
  describe 'PATCH coupon' do
    it 'returns http success' do
      promotion_product = create(:product, name: 'Bla', product_key: 'ABC')
      promotion = create(:promotion, :approved, discount: 10,
                                                product: promotion_product)
      coupon = create(:coupon, promotion: promotion)
      coupon.update code: Coupon.generate_code(coupon.promotion.prefix)

      uri = "/api/v1/coupons/#{coupon.code}/burn"

      patch uri, params: { order_number: 123, product_id: promotion_product.id }
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json).not_to be_empty
      expect(json['discount']).to eq('10.0')
    end

    it 'validate product relation' do
      promotion_product = create(:product, name: 'Bla', product_key: 'ABC')
      promotion = create(:promotion, discount: 10, product: promotion_product)
      coupon = create(:coupon, promotion: promotion)
      coupon.update code: Coupon.generate_code(coupon.promotion.prefix)

      uri = "/api/v1/coupons/#{coupon.code}/burn"

      patch uri, params: { order_number: 123, product_id: 20 }
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:precondition_failed)
      expect(json).to eq('Coupon does not relate to the product given')
    end

    it 'returns http not found' do
      order_number = 1234
      uri = '/api/v1/coupons/CodeInvalid/burn'

      patch uri, params: { order_number: order_number }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:not_found)
      expect(json).to eq('Coupon does not exist')
    end

    it 'fails if order number is absent' do
      coupon = create(:coupon, promotion: create(:promotion, discount: 10))
      coupon.update code: Coupon.generate_code(coupon.promotion.prefix)

      patch "/api/v1/coupons/#{coupon.code}/burn"
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:precondition_failed)
      expect(json).to eq(
        'Order number and Product Id is necessary to consume a coupon'
      )
    end

    it 'fails if coupon has already been used' do
      coupon = create(:coupon, promotion: create(:promotion, name: 'Bla',
                                                 prefix: 'ABC'))
      coupon.update code: Coupon.generate_code(coupon.promotion.prefix)
      coupon.create_usage
      order_number = 1234

      uri = "/api/v1/coupons/#{coupon.code}/burn"

      patch uri, params: { order_number: order_number }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:precondition_failed)
      expect(json).to eq('Coupon has already been used')
    end

    it 'fails if promotion is expired' do
      travel_to Time.zone.local(2010, 0o1, 0o1)
      product = create(:product, name: 'Bla', product_key: 'ABC')
      promotion = create(:promotion, :approved, discount: 10, product: product,
                        name: 'Bla')
      promotion.active!
      coupon = create(:coupon, promotion: promotion)
      coupon.update code: Coupon.generate_code(coupon.promotion.prefix)
      travel_back
      order_number = 1234

      uri = "/api/v1/coupons/#{coupon.code}/burn"

      patch uri, params: { order_number: order_number, product_id: product.id }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:precondition_failed)
      expect(json).to eq('Coupon\'s promotion is expired.')
    end
  end
end
