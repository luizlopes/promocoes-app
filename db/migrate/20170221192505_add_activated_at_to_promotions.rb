class AddActivatedAtToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :activated_at, :datetime
  end
end
