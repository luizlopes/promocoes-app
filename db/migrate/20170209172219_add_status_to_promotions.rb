class AddStatusToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :status, :integer
  end
end
