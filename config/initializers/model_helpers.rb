ActiveSupport.on_load(:active_record) do
  include Pna::HasRegion
  include Pna::HasContactInfo
  include Pna::HasNote
end
