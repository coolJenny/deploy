class VendorCategoriesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @categories = VendorCategory.all
  end

  def new
    @vendorcategory = VendorCategory.new
  end

  def edit
    @vendorcategory = VendorCategory.find(params[:id])
  end

  def update
    vendorcategory = VendorCategory.find(params[:id])
    if vendorcategory.update(vc_params)
      redirect_to vendor_categories_path()
    else
      flash[:notice] = 'User data is not updated'     
    end
  end

  def create
    @vendorcategory = VendorCategory.new(vc_params)
    if @vendorcategory.save
      redirect_to vendor_categories_path()
    else
      flash[:notice] = 'Category was not created.'
      redirect_to :back
    end
  end

  def destroy
    # vendorcategory = VendorCategory.find(params[:id])
  end

  private

  def vc_params
    params.require(:vendor_category).permit(:name)
  end
end
