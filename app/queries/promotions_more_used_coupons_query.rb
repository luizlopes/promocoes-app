class PromotionsMoreUsedCouponsQuery

  def self.call
    Promotion.joins(:coupons).group(:id).order('count(promotions.id) DESC')
  end
end
