class RemoveUserIdFromPromotions < ActiveRecord::Migration[5.0]
  def change
    remove_column :promotions, :creation_user_id, :integer
  end
end
