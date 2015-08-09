class AddNaNumberToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :na_number, :string
  end
end
