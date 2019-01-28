class CreateCouponUsages < ActiveRecord::Migration[5.2]
  def change
    create_table :coupon_usages do |t|
      t.references :coupon, foreign_key: true

      t.timestamps
    end
  end
end
