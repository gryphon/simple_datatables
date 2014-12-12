require 'rails'

Mime::Type.register_alias "application/json", :datatables

module SimpleDatatables
  module Rails
    require 'simple_datatables/engine'
  end
end
