class AddApprovalUserToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :approval_user_id, :integer
    add_foreign_key :promotions, :users, column: :approval_user_id
  end
end
