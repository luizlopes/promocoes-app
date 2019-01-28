class RemoveAmountFromPromotions < ActiveRecord::Migration[5.0]
  def change
    remove_column :promotions, :amount, :integer
  end
end
