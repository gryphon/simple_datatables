require 'rails'

Mime::Type.register "application/json", :datatables

module RailsDatatables
  module Rails
    require 'rails_datatables/engine'
  end
end
