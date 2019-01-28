class RemoveApprovedFromPromotions < ActiveRecord::Migration[5.0]
  def change
    remove_column :promotions, :approved, :integer
  end
end
