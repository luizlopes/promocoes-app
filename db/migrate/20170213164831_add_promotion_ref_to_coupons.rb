class AddPromotionRefToCoupons < ActiveRecord::Migration[5.0]
  def change
    add_reference :coupons, :promotion, foreign_key: true
  end
end
