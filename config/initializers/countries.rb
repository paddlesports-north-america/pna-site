begin
  ActionView::Helpers::FormOptionsHelper::COUNTRIES = Country.order( 'name ASC' ).map { |c| [ c.name, c.id ] }
  PRIORITY_COUNTRIES = [
    [ 'United States', Country.find_by_name( 'United States' ).id ],
    [ 'Canada', Country.find_by_name( 'Canada' ).id ],
    [ 'Mexico', Country.find_by_name( 'Mexico' ).id ]
  ] #Country.where( :name => [ 'United States', 'Canada', 'Mexico' ] ).map { |c| [ c.name, c.id ] }
rescue
  Rails.logger.warn "Failed to initialize countries constant"
end
