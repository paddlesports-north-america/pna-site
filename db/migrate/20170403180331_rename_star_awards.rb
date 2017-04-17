class RenameStarAwards < ActiveRecord::Migration

  def change
    # Change the print template for everything that is an endorsement to an attendance and strip Endorsement from the
    # end of the mod water endorsements so they make more sense when printed and change those print templates to endorsement
    # Note the trailing space character
    execute <<-SQL
      update awards set name='Sea Kayak Leader' where name='4 Star Sea Leader';
      update awards set name='Surf Kayak Leader' where name='4 Star Surf Leader';
      update awards set name='Canoe Leader' where name='4 Star Canoe Leader';
      update awards set name='White Water Kayak Leader' where name='4 Star White Water Leader';
      update awards set name='White Water OC1 Leader' where name='4 Star White Water OC1 Leader';
      update awards set name='Advanced Sea Kayak Leader' where name='5 Star Sea Leader';
      update awards set name='Advanced Surf Kayak Leader' where name='5 Star Surf Leader';
      update awards set name='Advanced Canoe Leader' where name='5 Star Canoe Leader';
      update awards set name='Advanced White Water Kayak Leader' where name='5 Star White Water Leader';
      update awards set name='Advanced White Water OC1 Leader' where name='5 Star White Water OC1 Leader';
      update awards set name='Surf Kayak Leader Provider' where name='4 Star Surf Provider';
      update awards set name='White Water Kayak Leader Provider' where name='4 Star White Water Provider';
      update awards set name='Canoe Leader Provider' where name='4 Star Canoe Provider';
      update awards set name='Sea Kayak Leader Provider' where name='4 Star Sea Provider';
      update awards set name='Advanced Sea Kayak Leader Provider' where name='5 Star Sea Provider';
      update awards set name='Advanced Canoe Leader Provider' where name='5 Star Canoe Provider';
      update awards set name='Advanced White Water Kayak Leader Provider' where name='5 Star White Water Provider';
      update awards set name='Advanced Surf Kayak Leader Provider' where name='5 Star Surf Provider';
    SQL
  end
end
