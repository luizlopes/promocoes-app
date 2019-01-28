class AddProductRefToPromotion < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :promotions, :products, column: :products_id
  end
end
