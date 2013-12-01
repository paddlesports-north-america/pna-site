class ChangeDateToExpDateOnFirstaid < ActiveRecord::Migration
  def change
    rename_column :first_aid_certifications, :date, :expiration_date
  end
end
