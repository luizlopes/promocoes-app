module CouponApiHelper
  # rubocop:disable Metrics/MethodLength
  def message_request_error
    if @coupon.blank?
      msg = 'Coupon does not exist'
      status = :not_found
    elsif @coupon.unavailable?
      msg = 'Coupon has already been used'
      status = :precondition_failed
    else
      msg = 'Order number and Product Id is necessary to consume a coupon'
      status = :precondition_failed
    end
    render json: msg.to_json, status: status
  end
  # rubocop:enable Metrics/MethodLength

  def params_present?
    params[:order_number] && params[:product_id]
  end
end
