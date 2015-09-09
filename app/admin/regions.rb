ActiveAdmin.register Region do
  menu :parent => 'Settings'

  config.batch_actions = false

end

ActiveAdmin.register RegionLocation do
  belongs_to :region
end