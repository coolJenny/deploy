class Api::VendoritemController < ActionController::Base

  def getitemlist

    vendoritem_columns = ['id','cost','upc','created_at','name','vendorsku','packcount']
    notsearch_columns = ['packcost', 'margin', 'profit', 'packcost']

    start = params[:iDisplayStart].to_i
    limit = params[:iDisplayLength].to_i
    vendor_id = params[:vendor]

    # byebug
    inventories = Vendoritem.joins(:vendorasin).where('vendor_id = ?',1)
    # inventories = Vendoritem.all
    total = inventories.count

    sort_columnIndex = params[:iSortCol_0].to_i;
    sort_columnName = params["mDataProp_#{sort_columnIndex}"]

    sort_order = params[:sSortDir_0]


    
    iColumns = params[:iColumns].to_i

    i=0
    true_search = "";
    while i < iColumns do
      search = params["sSearch_#{i}"]
      unless search.nil? || search == ''
        true_search = search
        search_column = params["mDataProp_#{i}"]

        unless notsearch_columns.include? search_column
          if vendoritem_columns.include? search_column
            inventories = inventories.where("cast(vendoritems.#{search_column} AS text) LIKE :l_name",{:l_name => "%#{search}%"}) unless search.blank?

          else
            inventories = inventories.where("cast(vendorasins.#{search_column} AS text) LIKE :l_name",{:l_name => "%#{search}%"}) unless search.blank?
          end
        end
       
      end
      i = i + 1
    end
    

    # byebug    
    if sort_columnName == 'margin'
      # byebug
      inventories = inventories.order("(vendorasins.buyboxprice-cost-vendorasins.totalfbafee) / vendoritems.cost #{sort_order}")
      # inventories = inventories.order("vendoritems.margin #{sort_order}")
      filtered = inventories.count
      inventories =inventories.limit(limit).offset(start)
    elsif sort_columnName == 'profit'
      inventories = inventories.order("vendorasins.buyboxprice-cost-vendorasins.totalfbafee #{sort_order}")
      # inventories = inventories.order("vendoritems.margin #{sort_order}")
      filtered = inventories.count
      inventories =inventories.limit(limit).offset(start)
    elsif sort_columnName == 'packcost'
      inventories = inventories.order("vendoritems.cost*vendoritems.packcount #{sort_order}")
      filtered = inventories.count
      inventories =inventories.limit(limit).offset(start)
    else
      if vendoritem_columns.include? sort_columnName
        inventories = inventories.order("vendoritems.#{sort_columnName} #{sort_order}")
        filtered = inventories.count
        inventories =inventories.limit(limit).offset(start)
      else
        inventories = inventories.order("vendorasins.#{sort_columnName} #{sort_order}")
        filtered = inventories.count
        inventories =inventories.limit(limit).offset(start)    
      end
    end
    render json: {'aaData'=>inventories,"iTotalRecords": total,"iTotalDisplayRecords": filtered}
  end

  def updatevendoritem
    @vendoritem = nil

    data = params[:data]
    data.each do |key, item|
      @vendoritem = Vendoritem.find(key)
      item.each do |title, value|
        @vendoritem[title.to_sym] = value
      end
    end
    @vendoritem.save
    render json: {'data'=>@vendoritem}
  end

end

# query = {name: 'a', asin: 'b'}

# @items = VendorItem.all
# query.each do |key, q|
#   @items = @items.where("? like ?", key, q)

# end