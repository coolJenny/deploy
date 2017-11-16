class VendoritemsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @company_id = params[:company]
    @vendor_id = params[:vendor]
    # byebug
    if @vendor_id.nil? || @vendor_id.empty?
      if current_user.company.vendors.present?
        @vendor_id = current_user.company.vendors.first.id
      else
        redirect_to vendors_path(:user => current_user), :flash => { :notice => "Please create Vednor first." }
      end
      
    end

    # respond_to do |format|
    #   format.json do
    #     @items.to_json(include: [:vendorasin, ])
    #   end

    #   format.html do
    #   end
    # end
  end

  # def getitemlist
  #   byebug
  #   vendor_id = params[:vendor]
  #   @vendoritems = Vendoritem.where(:vendor_id => vendor_id)
  #   respond_to do |format|
  #     format.json { render json: { results: @vendoritems.as_json} }
  #   end
  # end

  def show
    
  end
end
