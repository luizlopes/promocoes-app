class AddOrderNumberToCoupons < ActiveRecord::Migration[5.0]
  def change
    add_column :coupons, :order_number, :integer
  end
end
