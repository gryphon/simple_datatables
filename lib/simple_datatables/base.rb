module SimpleDatatables

  module ActiveRecord

    module ClassMethods
    
      def datatables controller, params, &block
        
        meta = {}
        
        meta["meta_sort"] = "name.asc"
        
        objects = self.search(params["search"]).paginate(:page => params[:page], :per_page => params[:per_page])
        
        json = Jsonify::Builder. new
        json.sEcho params["sEcho"]
        
        if objects.count > 0
          json.iTotalRecords objects.count
          json.iTotalDisplayRecords objects.total_entries
          json.aaData _yield_object controller, objects, block
        else
          json.iTotalRecords 0
          json.iTotalDisplayRecords 0
          json.aaData []
        end
        json.compile!
      end
  
  
      private
      
        def _yield_object controller, objects, block
          objects.map do |object|
            block[object].map do |string|
              controller.instance_eval %{
                Rails.logger.silence do
                  render_to_string :inline => %Q|#{string}|, :locals => {:#{self.name.underscore} => object}
                end
              }
            end
          end
        end
  
      end
  
  end

end
