Mime::Type.register "application/json", :datatables

module SimpleDatatables
  class Railtie < Rails::Railtie
    initializer 'simple_datatable.initialize' do
      ActiveSupport.on_load(:active_record) do
        ::ActiveRecord::Base.send :extend, SimpleDatatables::ActiveRecord::ClassMethods
      end
    end
  end
end
