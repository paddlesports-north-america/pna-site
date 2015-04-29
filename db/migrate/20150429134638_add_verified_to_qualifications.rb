class AddVerifiedToQualifications < ActiveRecord::Migration
  def change
    add_column :qualifications, :verified, :boolean
  end
end
