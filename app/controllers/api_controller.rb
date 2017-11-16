class ApiController < ActionController::Base
  
  def documentation
    render file: "app/assets/documentation/readme.md"
  end

  def datatable
    render file: "app/assets/api/datatable.json"
  end

  def jqgrid
    render file: "app/assets/api/jqgrid.json"
  end

  def jqgridtree
    render file: "app/assets/api/jqgrid-tree.json"
  end

  def i18n
    # locale param was defined in config/routes.rb
    render file: "app/assets/i18n/" + params['locale']
  end

  def xeditablegroups
    render file: "app/assets/api/xeditable-groups.json"
  end

  def xeditable
    render :nothing => true
  end


  # def skynetgridhistory
  #   page = params[:page].to_i
  #   limit = params[:rows].to_i
  #   sidx = params[:sidx]
  #   sord = params[:sord]
  #   search = params[:_search]
    
  #   # byebug
  #   totalskynets = current_user.skynets

    

  #   if search == "true"
  #     filters = params[:filters]
  #     filters = ActiveSupport::JSON.decode(filters)
  #     search_data = filters['rules']

  #     search_data.each do |search_column|
  #       # byebug
  #       totalskynets = totalskynets.search_columns(search_column['data']) unless search_column['data'].blank?
  #     end
  #   end

  #   totalcount = totalskynets.count
  #   totalpages = 0
  #   if totalcount > 0 
  #     totalpages = totalcount / limit.to_f
  #     totalpages = totalpages.ceil
  #   end

  #   if page > totalpages
  #     page = totalpages
  #   end

  #   start = limit*page - limit
  #   if start < 0
  #     start = 0
  #   end
  #   # skynets = current_user.skynets.order('created_at DESC').limit(limit).offset(start)
  #   skynets = totalskynets.order("#{sidx} #{sord}").limit(limit).offset(start)
  #   render json: {'rows'=>skynets, 'page'=>page, 'total'=>totalpages, 'records'=>totalcount}
  # end


  # def venderitemlist

  #   vendoritem_columns = ['id','cost','upc','created_at','name']

  #   page = (params[:page] || 0).to_i
  #   limit = params[:rows].to_i
  #   sidx = params[:sidx]
  #   sord = params[:sord]
  #   vendor_id = params[:vendor_id]
  #   search = params[:_search]

  #   inventories = Vendoritem.where('vendor_id = ?',vendor_id)

  #   if search == "true"
  #     filters = params[:filters]
  #     filters = ActiveSupport::JSON.decode(filters)
  #     search_data = filters['rules']

  #     search_data.each do |search_column|
  #       inventories = inventories.search_columns(search_column['data']) unless search_column['data'].blank?
  #     end
  #   end

  #   totalcount = inventories.count
  #   totalpages = 0
  #   if totalcount > 0 
  #     totalpages = totalcount / limit.to_f
  #     totalpages = totalpages.ceil
  #   end

  #   if page > totalpages
  #     page = totalpages
  #   end

  #   start = limit*page - limit
  #   if start < 0
  #     start = 0
  #   end

  #   if vendoritem_columns.include? sidx
  #     inventories = inventories.order("#{sidx} #{sord}").limit(limit).offset(start)
  #   else
  #     inventories = inventories.includes(:vendorasin).order("vendorasins.#{sidx} #{sord}").limit(limit).offset(start)    
  #   end
    
  #   render json: {'rows'=>inventories, 'page'=>page, 'total'=>totalpages, 'records'=>totalcount}
  # end

  

end
