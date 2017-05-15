class AddQualificationUniqueness < ActiveRecord::Migration
  def change
    # First we need to remove duplicate records.
    records = Qualification.connection.select_all('select qo.id, qo.member_id, qo.award_id, qo.most_recent_award from qualifications qo inner join
        (select member_id, award_id, count(*) from qualifications group by member_id, award_id having count(*) > 1 order by member_id) as qi on qo.member_id=qi.member_id and qo.award_id=qi.award_id order by member_id, award_id, most_recent_award desc')
    @dead_recs = []
    @current_member_id = -1
    @current_award_id = -1

    records.each { | record |
      if record['member_id'] != @current_member_id || record['award_id'] != @current_award_id
        @current_member_id = record['member_id']
        @current_award_id = record['award_id']
      else
        @dead_recs << record['id']
      end
    }
    Qualification.delete(@dead_recs)
    add_index(:qualifications, [:member_id, :award_id], :unique => true, :name => 'one_qual_type_per')
  end
end
