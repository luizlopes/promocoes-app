class RemoveCreationDateFromPromotions < ActiveRecord::Migration[5.0]
  def change
    remove_column :promotions, :creation_date, :datetime
  end
end
