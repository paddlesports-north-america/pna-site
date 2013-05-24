class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.string :description
      t.float :amount
      t.string :category

      t.timestamps
    end
  end
end
