ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  # content :title => proc{ I18n.t("active_admin.dashboard") } do
  #   columns do
  #     column do
  #       panel "Recently updated content" do
  #         table_for Version.order('id desc').limit(20) do
  #           column "Type" do |v| v.item_type.underscore.humanize end
  #           column "Item" do |v| v.item end
  #           column "Modified at" do |v| v.created_at.to_s :long end
  #           column "Admin" do |v| link_to AdminUser.find(v.whodunnit).email, admin_admin_user_path(AdminUser.find(v.whodunnit)) end
  #         end
  #       end
  #     end
  #     column do
  #       panel "Upcoming Courses" do
  #         table_for Course.upcoming.limit( 20 ) do
  #           column :start_date
  #           column :program
  #           column :center
  #           column :venue
  #           column :state
  #         end
  #       end
  #     end
  #   end
  # end # content
end
