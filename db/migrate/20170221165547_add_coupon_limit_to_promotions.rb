class AddCouponLimitToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :coupon_limit, :integer
  end
end
