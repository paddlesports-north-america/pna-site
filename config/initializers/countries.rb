ActionView::Helpers::FormOptionsHelper::COUNTRIES = Country.order( 'name ASC' ).map { |c| [ c.name, c.id ] }
PRIORITY_COUNTRIES = Country.where( :name => [ 'United States', 'Canada', 'Mexico' ] ).map { |c| [ c.name, c.id ] }
