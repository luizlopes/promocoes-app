class ExpirePromotionsJob
  def perform
    promotion = Promotion.find(@promotion_id)
    promotion.promotion_expired?
  end

  def self.auto_enqueue(promotion_id)
    Delayed::Job.enqueue(ExpirePromotionsJob.new(promotion_id))
  end

  def initialize(promotion_id)
    @promotion_id = promotion_id
  end
end
