class AddStartAtToPromotion < ActiveRecord::Migration[5.2]
  def change
    add_column :promotions, :start_at, :datetime
  end
end
