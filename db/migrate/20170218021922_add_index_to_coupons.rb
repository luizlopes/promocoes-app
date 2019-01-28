class AddIndexToCoupons < ActiveRecord::Migration[5.0]
  def change
    add_index :coupons, :code, unique: true
  end
end
