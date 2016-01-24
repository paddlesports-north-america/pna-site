class AddPrintTemplateToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :print_template, :string

    Award.all.each do |a|
      if a.award_type == Pna::ProgramType::LEADERSHIP
        a.print_template = Pna::PrintTemplate::PERFORMANCE
      else
        a.print_template = a.award_type
      end
      a.save
    end
  end
end
