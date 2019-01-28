class Api::V1::CouponsController < Api::V1::ApiController
  include CouponApiHelper
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def burn
    @coupon = Coupon.find_by(code: params[:id])
    if @coupon&.available? && params_present?
      if @coupon.promotion.promotion_expired?
        render json: "Coupon's promotion is expired.".to_json,
               status: :precondition_failed
      elsif params[:product_id].to_i == @coupon.promotion.product_id
        @coupon.update order_number: params[:order_number],
                       status: :unavailable
        @coupon.create_usage
        render json: { discount: @coupon.promotion.discount }, status: :ok
      else
        render json: 'Coupon does not relate to the product given'.to_json,
               status: :precondition_failed
      end
    else
      message_request_error
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def show
    @coupon = Coupon.find_by(code: params[:id])
    if @coupon
      render json: { status: @coupon.status,
                     discount: @coupon.promotion.discount,
                     promotion_name: @coupon.promotion.name }, status: :ok
    else
      message_request_error
    end
  end
end
