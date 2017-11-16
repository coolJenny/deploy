class Api::SkynetController < ActionController::Base
  # skip_before_filter :user_authenticated?

  def index
    @items = VendorItem.includes(:vendorasin).search(params[:query])
    @items = @items.active
    @items = @items.page(params[:page]).per(params[:rows])

    render json: @items
  end

  def skynethisotry
    start = params[:iDisplayStart].to_i
    limit = params[:iDisplayLength].to_i
    
    total = current_user.company.skynets.all.count

    sort_columnIndex = params[:iSortCol_0].to_i;
    sort_columnName = params["mDataProp_#{sort_columnIndex}"]

    sort_order = params[:sSortDir_0]

    vendor_prefix = ''
    if sort_columnName == 'name'
      vendor_prefix = 'vendors.';
    end
    search = params[:sSearch]
    unless search.nil? || search == ''
      skynets = current_user.company.skynets.where('inputfilename like ?',"%#{search}%")
      filtered = skynets.count
      skynets = skynets.includes(:vendor).order.order("#{vendor_prefix}#{sort_columnName} #{sort_order}").limit(limit).offset(start)
      
    else
      skynets = current_user.company.skynets.includes(:vendor).order("#{vendor_prefix}#{sort_columnName} #{sort_order}")
      filtered = skynets.count
      skynets =skynets.limit(limit).offset(start)
      
    end
    render json: {'aaData'=>skynets,"iTotalRecords": total,"iTotalDisplayRecords": filtered}

  end

end

# query = {name: 'a', asin: 'b'}

# @items = VendorItem.all
# query.each do |key, q|
#   @items = @items.where("? like ?", key, q)

# end