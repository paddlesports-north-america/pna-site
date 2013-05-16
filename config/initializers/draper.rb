# Latest version of draper does some weirdness with active admin pagination
# see https://github.com/gregbell/active_admin/issues/1895 for details
Draper::CollectionDecorator.delegate :reorder, :page, :current_page, :total_pages, :limit_value, :total_count, :num_pages
