class AddProductToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :product_id, :integer
  end
end
