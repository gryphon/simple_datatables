require 'rails'

Mime::Type.register "application/json", :datatables

module SimpleDatatables
  module Rails
    require 'simple_datatables/engine'
  end
end
