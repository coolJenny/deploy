require 'net/http'
require 'net/ftp'

class SkynetsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :index, :show, :download, :history]
  skip_before_filter :verify_authenticity_token, :only => [:importskynet, :insertskynet]
  def new
    # @skynets = current_user.skynets
    
    @company_id = params[:company]
    @vendor_id = params[:vendor]
    if @vendor_id.nil? || @vendor_id.empty?
      if current_user.company.vendors.present?
        @vendor_id = current_user.company.vendors.first.id
      else
        redirect_to vendors_path(:user => current_user), :flash => { :notice => "Please create Vednor first." }
      end
    end
    
    @skynet = Skynet.new 
    @row = ['None']
    @tempfile = params[:file]
    @name = params[:name]
    # File.open(File.join('public', 'template', 'a.txt'), 'wb') do |file|
    #   file.write('qwe')
    # end
    unless !@tempfile || @tempfile.blank?
      tempfile_path = File.join('public', 'skynets', @tempfile).to_s
      @row = ItemIngestion.read_row(tempfile_path, 1)
      if @row == false
        @row = ['None']
        @name = "File format is not supported."
      else
        @row.unshift("None")  
      end
      # @name = @tempfile
    end
  end

  def create
    formtype = params[:form_type]
    byebug
    if formtype == 'fileupload'
      # byebug
      @file_field = params[:file_field]
      @original_filename = @file_field.original_filename
      restored_filename = Digest::SHA1.hexdigest Time.now.to_s
      restored_filename = restored_filename + '.csv'
      extension = File.extname(@original_filename)
      if extension == '.xls' || extension == '.xlsx'
        # convertExceltoCSV(uploaded_io,File.join('public', 'skynets', restored_filename))
        ItemIngestion.to_csv(@file_field,File.join('public', 'skynets', restored_filename))
      elsif extension == '.csv'
        File.open(File.join('public', 'skynets', restored_filename), 'wb') do |file|
          file.write(@file_field.read)
        end
        # Net::FTP.open('216.55.169.119', 'fbasup@wraithco.com', 'im&Ax+lhV4_U') do |ftp|
        #   ftp.putbinaryfile(@file_field, "/#{restored_filename}")
        #   # ftp.storbinary(restored_filename, StringIO.new(@file_field.read), Net::FTP::DEFAULT_BLOCKSIZE)
        #   ftp.passive = true
        # end
      else
        redirect_to new_skynet_path
        return
      end
      
      # ItemIngestion.to_csv(@file_field,File.join('public', 'skynets', restored_filename))
      redirect_to new_skynet_path :file=>restored_filename, :name=>@original_filename
    elsif formtype == 'selectheader'

      @skynet = Skynet.new(skynet_params)
      
      restored_filename = params[:file_path]
      filename = params[:file_name]

      @skynet.inputfileurl = restored_filename
      @skynet.inputfilename = filename
      @skynet.user_id = current_user.id
      @skynet.vendor_id = params[:vendor_id]
      @skynet.skynet_id_type_id = params[:skynet][:skynet_id_type_id]
      
      id_header = params[:index_header]
      if id_header == "None"
        flash[:notice] = 'Id is not selected.'
        redirect_to :back
      end

      cost_header = params[:cost_header]
      if cost_header == "None"
        flash[:notice] = 'COST is not selected.'
        redirect_to :back
      end

      sku_header = params[:vendorsku_header]
      if sku_header == "None"
        flash[:notice] = 'SKU is not selected.'
        redirect_to :back
      end

      skynetparams = {"apikey" => "bc6418e5-d86d-4822-bfee-e154cb145eb5", "InputfileUrl" => request.original_url+'/'+restored_filename,"InputfileName" => filename, "IdType" => params[:skynet][:skynet_id_type_id], "IdHeaderName" => id_header, "CostHeaderName" => cost_header, "VendorSKUHeaderName" => sku_header, "ShippingCostPerLb" => 0,  "GetEstimatedSales" => true, "GetIsAmazonSelling" => true, "WebhookForProgress" => "http://www.fba.support/importskynet", "VendorId" => params[:vendor_id], "VendorName" => @skynet.vendor.name, "NeedEstimatedSalesPerMonth" => true, "NeedIsAmazonSelling" => true, "NeedBuyboxEligibleOffers" => true, "WebhookForComplete" => 'http://www.fba.support/insertskynet'}

      create_skynet_task(skynetparams.to_json)
      @skynet.task_id =  @created['TaskId']
      @skynet.skynet_status_id = 0

      if @created['Message'] == 'An error has occurred.'
        flash[:notice] = 'TaskId is not generated'
        redirect_to :back
      else
        if @skynet.save
          redirect_to :back
        else
          flash[:notice] = 'Skynet was not created.<br>Please check the information'
          redirect_to :back
        end
      end

    end

  end

  def index
    @skynets = current_user.skynets
    @skynet = Skynet.new
  end

  def show
    filename = params[:name]
  end

  def download
    filename = params[:name]
    out = params[:out]
    if out
      if filename != nil
        send_file (filename), :x_sendfile=>true
      else
        redirect_to :back        
      end
    else 
      send_file File.join('public','skynets',filename), :type=>"text/csv", :x_sendfile=>true
    end
  end

  def history
    # skynets = current_user.skynets
    # respond_to do |fmt|
    #   fmt.html
    #   fmt.json
    # end
    render file: "app/assets/api/datatable.json"
  end

  def importskynet
    taskid = params[:TaskId]
    skynet = Skynet.find_by task_id: taskid
    if skynet != nil
      skynet.skynet_status_id = params[:Status]
      skynet.outputfileurl = params[:OutputFileUrl]
      skynet.statusmessage = params[:StatusMessage]
      skynet.save
      render json: {
        status: 'OK',
      }.to_json
    else
      render json: {
        status: 'Error',
        todo_list: params
      }.to_json  
    end
  end

  def insertskynet
    
    @u = User.first
    @u.active = false
    @u.save
    restored_filename = Digest::SHA1.hexdigest Time.now.to_s
    restored_filename = restored_filename + '.xml'
    # restored_filename = '1.xml'
    File.open(File.join('public', 'temp', restored_filename), 'wb') do |file|
      file.write(request.body.read)
      # file.write('qwe')
    end

    f = File.open(File.join('public', 'temp', restored_filename))
    data = Nokogiri::XML(f)
    f.close

    idheadername = data.at_xpath("//OutputRows//IdHeaderName").text
    vendorid = data.at_xpath("//OutputRows//AdditionalData//VendorId").text
    idtype = data.at_xpath("//OutputRows//IdType").text
    
    vendor = Vendor.find(vendorid)
    @count = 0
    data.xpath('//OutputRows//Results//OutputRowInProcess').each do |row|
      @count += 1
      asintext = row.xpath("ASIN").text
      
      vendoritem = vendor.vendoritem.where(:asin => asintext).first_or_create


      brandtext = row.xpath("Brand").text
      brand = Brand.where(:name => brandtext).first_or_create
      

      itemname = row.xpath("ItemName").text
      
      rank = row.xpath("SalesRank").text

      rankcategorytext = row.xpath("SalesRankCategory").text
      rankcategory = RakedCategory.where(:name => rankcategorytext).first_or_create

      packageqty = row.xpath("PackageQuantity").text
      bbp = row.xpath("BuyBoxPrice").text
      amazonoffers = row.xpath("AmazonOffers").text

      productgroup_text = row.xpath("ProductGroup").text
      productgroup = ProductGroup.where(:name => productgroup_text).first_or_create
      


      producttype_text = row.xpath("ProductTypeName").text
      producttype = ProductType.where(:name => producttype_text).first_or_create
      itemweight = (row.xpath("ItemWeight").text || 0).to_f
      itemlength = (row.xpath("ItemLength").text || 0).to_f
      itemwidth = (row.xpath("ItemWidth").text || 0).to_f
      itemheight = (row.xpath("ItemHeight").text || 0).to_f
      packageweight = (row.xpath("PackageWeight").text || 0).to_f
      packagelength = (row.xpath("PackageLength").text || 0).to_f
      packagewidth = (row.xpath("PackageWidth").text || 0).to_f
      packageheight = (row.xpath("PackageHeight").text || 0).to_f
      notes = row.xpath("Notes").text
      fbafee = (row.xpath("FBAFee").text || 0).to_f
      storagefee = (row.xpath("StorageFee").text || 0).to_f
      variableclosingfee = (row.xpath("VariableClosingFee").text || 0).to_f
      commissionfee = (row.xpath("CommissionFee").text || 0).to_f
      commissionpct = (row.xpath("CommissionPct").text || 0).to_i
      totalfbafee = (row.xpath("TotalFBAFee").text || 0).to_f
      numtotaloffers = (row.xpath("NumTotalOffers").text || 0).to_i
      numfbaoffer = (row.xpath("NumFBAOffers").text || 0).to_i
      numfbmoffer = (row.xpath("NumMFNOffers").text || 0).to_i
      lowestfbaoffer = (row.xpath("LowestFBAOffer").text || 0).to_f
      lowestfbmoffer = (row.xpath("LowestMFNOffer").text || 0).to_f
      id = row.xpath("Id").text
      purchaseprice = (row.xpath("PurchasePrice").text || 0).to_f
      invalidid = row.xpath("InvalidId").text
      estsalespermonth = (row.xpath("EstSalesPerMonth").text || 0).to_i
      isbuyboxfba = row.xpath("IsBuyboxFBA").text
      reviewrating = (row.xpath("ReviewRating").text || 0).to_f
      reviews = (row.xpath("NumReviews").text || 0).to_i
      ean = row.xpath("EAN").text
      mpn = row.xpath("MPN").text

      asin = Vendorasin.where(:asin => asintext).first_or_create
      asin.brand_id= brand.id
      asin.name= itemname
      asin.salesrank= rank
      asin.packagequantity= packageqty
      asin.buyboxprice= bbp.to_f
      asin.amazonoffer= amazonoffers
      asin.totalfbafee = totalfbafee
      asin.fbafee= fbafee
      asin.storagefee= storagefee
      asin.variableclosingfee= variableclosingfee
      asin.commissionpct= commissionpct
      asin.commissiionfee= commissionfee
      asin.salespermonth= estsalespermonth
      asin.totaloffers= numtotaloffers
      asin.fbaoffers= numfbaoffer
      asin.fbmoffers= numfbmoffer
      asin.lowestfbaoffer= lowestfbaoffer
      asin.lowestfbmoffer= lowestfbmoffer
      
      asin.product_type_id= producttype.id
      asin.ranked_category_id= rankcategory.id
      asin.product_groups_id= productgroup.id
      asin.weight= itemweight
      asin.length= itemlength
      asin.width= itemwidth
      asin.height= itemheight
      asin.packageweight= packageweight
      asin.packageheight= packageheight
      asin.packagewidth= packagewidth
      asin.packagelength= packagelength
      asin.notes= notes
      asin.review= reviewrating
      asin.numreview= reviews
      asin.ean = ean;
      asin.mpn = mpn;

      if isbuyboxfba == 'true'
        asin.isbuyboxfba= true
      else
        asin.isbuyboxfba= false
      end

      if invalidid == 'true'
        asin.invalidid = true
      else
        asin.invalidid = false
      end

      asin.save

      cost = (row.xpath("PurchasePrice").text || 0).to_f

      upc = row.xpath("UPC").text

      vendorsku = row.xpath("VendorSKU").text

      vendoritem.vendorasin_id = asin.id
      vendoritem.name = itemname
      vendoritem.upc = upc
      vendoritem.cost = cost
      vendoritem.vendorsku = vendorsku

      vendoritem.save


    end
    render :text => @u.id
  end

  private
  
  def skynet_params
    params.require(:skynet).permit(:skynet_id_type_id, :vendor_id, )
  end

  def create_skynet_task(params)
    @created = HTTParty.post('http://skynet2.azurewebsites.net/api/ProfitSourcing/CreateTask', :body => params,:headers => { 'Content-Type' => 'application/json', 'apikey' => 'bc6418e5-d86d-4822-bfee-e154cb145eb5' } )
  end

  def convertExceltoCSV(excelfile,target)
    
    ItemIngestion.to_csv(excelfile,target)
  end

end
