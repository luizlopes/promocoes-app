class AddUserToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :creation_user_id, :integer
    add_foreign_key :promotions, :users, column: :creation_user_id
  end
end
