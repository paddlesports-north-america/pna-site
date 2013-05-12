ActiveSupport.on_load(:active_record) do
  include Pna::ModelHelpers
end
