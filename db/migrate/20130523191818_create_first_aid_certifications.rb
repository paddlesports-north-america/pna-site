class CreateFirstAidCertifications < ActiveRecord::Migration
  def change
    create_table :first_aid_certifications do |t|
      t.string :provider
      t.date :date
      t.string :certification_type
      t.string :certification_level
      t.references :member

      t.timestamps
    end
    add_index :first_aid_certifications, :member_id
  end
end
