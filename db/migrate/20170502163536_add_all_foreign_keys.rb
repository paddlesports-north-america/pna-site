class AddAllForeignKeys < ActiveRecord::Migration
  def up
    add_foreign_key :address, :state, :name => 'addr_state_fk'
    add_foreign_key :address, :country, :name => 'addr_cntry_fk'

    add_foreign_key :centers_member, :member, :name => 'cntrmem_mem_fk'
    add_foreign_key :centers_member, :center, :name => 'cntrmem_cntr_fk'

    add_foreign_key :course_coach, :member, :name => 'ccoach_mem_fk'
    add_foreign_key :course_coach, :course, :name => 'ccoach_course_fk'

    add_foreign_key :course_participant, :member, :name => 'ccourse_mem_fk'
    add_foreign_key :course_participant, :course, :name => 'ccourse_course_fk'

    add_foreign_key :course, :program, :name => 'course_pgm_fk'
    add_foreign_key :course, :country, :name => 'course_cntr_fk'
    add_foreign_key :course, :state, :name => 'course_state_fk'
    add_foreign_key :course, :center, :name => 'course_center_fk'
    add_foreign_key :course, :member, :name => 'course_provider_fk', :column => 'course_provider_id'

    # Can't add an FK as below because emailable_id is polymorphic between members and centers.
    # This is why polymorphism be *intra* table, not *inter* table. Sigh
    # add_foreign_key :email_address, :member, :name => 'email_member_fk', :column => 'emailable_id'

    add_foreign_key :first_aid_certification, :member, :name => 'fa_cert_member_fk'

    add_foreign_key :membership, :member, :name => 'memship_mem_fk'
    add_foreign_key :membership, :membership_type, :name => 'memship_type_fk'

    add_foreign_key :program, :award, :name => 'pgm_award_fk'

    add_foreign_key :qualification, :member, :name => 'qual_member_fk'
    add_foreign_key :qualification, :award, :name => 'qual_award_fk'
    add_foreign_key :qualification, :course, :name => 'qual_course_fk'

    add_foreign_key :region_location, :region, :name => 'rloc_region_fk'

    add_foreign_key :region, :member, :name => 'region_member_fk', :column => 'rco_id'

    # Remove data that violates the upcoming fk...
    execute 'delete from registrations where not exists (select 1 from members where members.id=registrations.member_id)'
    add_foreign_key :registration, :member, :name => 'reg_member_fk'
    add_foreign_key :registration, :member, :name => 'reg_assessor_fk', :column => 'assessor_id'
    add_foreign_key :registration, :member, :name => 'reg_trainer_fk', :column => 'trainer_id'

    add_foreign_key :state, :country, :name => 'state_cntry_fk'
  end


  def down
    remove_foreign_key :address, :state, :name => 'addr_state_fk'
    remove_foreign_key :address, :country, :name => 'addr_cntry_fk'

    remove_foreign_key :centers_member, :member, :name => 'cntrmem_mem_fk'
    remove_foreign_key :centers_member, :center, :name => 'cntrmem_cntr_fk'

    remove_foreign_key :course_coach, :member, :name => 'ccoach_mem_fk'
    remove_foreign_key :course_coach, :course, :name => 'ccoach_course_fk'

    remove_foreign_key :course_participant, :member, :name => 'ccourse_mem_fk'
    remove_foreign_key :course_participant, :course, :name => 'ccourse_course_fk'

    remove_foreign_key :course, :program, :name => 'course_pgm_fk'
    remove_foreign_key :course, :country, :name => 'course_cntr_fk'
    remove_foreign_key :course, :state, :name => 'course_state_fk'
    remove_foreign_key :course, :center, :name => 'course_center_fk'
    remove_foreign_key :course, :member, :name => 'course_provider_fk', :column => 'course_provider_id'
    
    remove_foreign_key :first_aid_certification, :member, :name => 'fa_cert_member_fk'

    remove_foreign_key :membership, :member, :name => 'memship_mem_fk'
    remove_foreign_key :membership, :membership_type, :name => 'memship_type_fk'

    remove_foreign_key :program, :award, :name => 'pgm_award_fk'

    remove_foreign_key :qualification, :member, :name => 'qual_member_fk'
    remove_foreign_key :qualification, :award, :name => 'qual_award_fk'
    remove_foreign_key :qualification, :course, :name => 'qual_course_fk'

    remove_foreign_key :region_location, :region, :name => 'rloc_region_fk'

    remove_foreign_key :region, :member, :name => 'region_member_fk', :column => 'rco_id'

    remove_foreign_key :registration, :member, :name => 'reg_member_fk'
    remove_foreign_key :registration, :member, :name => 'reg_assessor_fk', :column => 'assessor_id'
    remove_foreign_key :registration, :member, :name => 'reg_trainer_fk', :column => 'trainer_id'

    remove_foreign_key :state, :country, :name => 'state_cntry_fk'
  end

  # Stupid method that builds up a Postgres FK constraint DDL string and execs it
  def add_foreign_key(from, to, options)
    options = fk_options(from, to, options)
    ddl = "ALTER TABLE #{options[:from_table]} ADD CONSTRAINT #{options[:name]} FOREIGN KEY (#{options[:column]}) REFERENCES #{options[:to_table]}"
    execute ddl
  end

  # Although not required the signature of this method is symetrical with add_foreign_key so that it's easy to add them
  # to the up/down methods
  def remove_foreign_key(from, to, options)
    options = fk_options(from, to, options)
    ddl = "ALTER TABLE #{options[:from_table]} DROP CONSTRAINT IF EXISTS #{options[:name]}"
    execute ddl
  end


  def fk_options(from, to, options)
    options = options.dup
    options[:from_table] = from.to_s.pluralize
    options[:to_table] = to.to_s.pluralize
    if !options.has_key?(:column)
      options[:column] = "#{to.to_s}_id"
    end
    options
  end
end
