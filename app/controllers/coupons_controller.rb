class CouponsController < ApplicationController
  before_action :set_promotion, only: %i[create index]
  before_action :authenticate_user!
  before_action :verify_promotion, only: [:index]

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def create
    amount = params[:amount].to_i
    count_coupon = params[:amount].to_i + @promotion.coupons.count
    if (@promotion.coupon_limit - count_coupon) > -1
      amount.times do
        code = Coupon.generate_code(@promotion.prefix)
        @coupon = current_user.coupons.new(code: code,
                                           promotion: @promotion,
                                           status: :available)
        @coupon.save
      end
    else
      flash[:danger] = 'Numero de cupons ultrapassa limite de emissao'\
                       ' estabelecido'
      redirect_to(promotion_path(@promotion)) && return
    end
    flash[:success] = 'Cupons criados com sucesso!'
    redirect_to promotion_coupons_path(@promotion)
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def index
    @promotion.coupons.each(&:unavailable!) if @promotion.expired?
    @coupons = @promotion.coupons
  end

  def destroy
    coupon = Coupon.find(params[:id])
    coupon.unavailable!
    flash[:success] = "Cupom #{coupon.code} invalidado com sucesso!"
    redirect_to promotion_coupons_path
  end

  private

  def set_promotion
    @promotion = Promotion.find(params[:promotion_id])
  end

  def verify_promotion
    @promotion.promotion_expired?
  end
end
