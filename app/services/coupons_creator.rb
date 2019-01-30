class CouponsCreator

  def initialize(promotion, user, amount)
    @promotion = promotion
    @user = user
    @amount = amount
  end

  def create
    return unless can_create?

    amount.times do
      create_cupon
    end
  end

  private 
  attr_reader :promotion, :user, :amount

  def can_create?
    count_coupon = amount + promotion.coupons.count
    (promotion.coupon_limit - count_coupon) > -1
  end

  def create_cupon
    code = Coupon.generate_code(promotion.prefix)
    coupon = user.coupons.new(code: code,
                              promotion: promotion,
                              status: :available)
    coupon.save
  end

end
