class VendorsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @vendor = Vendor.new
  end
  
  def create
    @vendor = Vendor.new(vendor_param)
    @vendor.user_id = current_user.id
    if @vendor.save
      redirect_to vendors_path(:user => current_user.id)
    else
      redirect_to :back
    end
    
  end

  def index
    @company_id = params[:company]
    @vendor_id = params[:vendor]
    # byebug
    if @vendor_id.nil? || @vendor_id.empty?
      if current_user.company.vendors.present?
        @vendor_id = current_user.company.vendors.first.id
      # else
      #   redirect_to vendors_path(:user => current_user), :flash => { :notice => "Please create Vednor first." }
      end
    end

    @user = User.find(params[:user])
    if @user.role.name == 'Admin'
      @vendors = Vendor.all;
    else
      @vendors = @user.company.vendors
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    vendor = Vendor.find(params[:id])
    if vendor.update(vendor_params)
      redirect_to vendors_path(:user => current_user.id)
    else
      flash[:notice] = 'User data is not updated'     
    end
  end

  def destroy
    vendor = Vendor.find(params[:id])
    vendor.delete
    redirect_to vendors_path(:user => current_user.id);
  end

  def show
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :addressline1, :addressline2, :city, :zipcode, :state, :account_number, :contact, :title, :phone, :email, :website, :dropship, :crossdock, :login, :password, :ref_name, :ref_title, :ref_email, :ref_fax, :leadtime, :vendor_category_id)
  end

  def vendor_param
    params.require(:vendor).permit(:name, :vendor_category_id, :account_number, :contact)
  end
end
