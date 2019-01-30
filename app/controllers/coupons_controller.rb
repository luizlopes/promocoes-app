class CouponsController < ApplicationController
  before_action :set_promotion, only: %i[create index]
  before_action :authenticate_user!
  before_action :verify_promotion, only: [:index]

  def create
    coupons_creator = CouponsCreator.new(@promotion, current_user, params[:amount].to_i)

    if coupons_creator.create
      flash[:success] = 'Cupons criados com sucesso!'
      redirect_to promotion_coupons_path(@promotion)
    else
      flash[:danger] = 'Numero de cupons ultrapassa limite de emissao'\
                       ' estabelecido'
      redirect_to(promotion_path(@promotion))
    end
  end

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
