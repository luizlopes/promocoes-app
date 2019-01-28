class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|
      t.text :description
      t.decimal :discount
      t.string :name
      t.integer :days
      t.string :prefix
      t.integer :amount
      t.integer :approved
      t.datetime :creation_date
      t.timestamps
    end
  end
end
