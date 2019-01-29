class PromotionBuilder
  def self.build(promotion_params, user)
    new(promotion_params, user).promotion
  end

  def promotion
    promotion = Promotion.new(promotion_params)
    promotion.product = Product.find(promotion.product_id)
    promotion.prefix = promotion.product.product_key
    promotion.creation_user_id = user.id
    promotion
  end

  attr_reader :promotion_params, :user

  def initialize(promotion_params, user)
    @promotion_params = promotion_params
    @user = user
  end
end
