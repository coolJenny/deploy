class CompaniesController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :show, :edit]
  layout :resolve_layout
  def new
    if !user_signed_in?
     @company = Company.new
    else
     session[:return_to] ||= request.referer
     redirect_to session.delete(:return_to)
    end
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to '/users/sign_up'
    else
      flash[:notice] = 'There is a duplicated name.'
      redirect_to :back
    end
  end

  def index
    @role = current_user.role.name
  end

  def show
    @company = Company.find(params[:id]);
    @users = User.where(company_id: params[:id])
  end

  def edit
    @company = Company.find(params[:id]);
  end
   
  def update
    @company = Company.find(params[:id])
    if @company.update(company_update_params)
      redirect_to company_path(params[:id])
    else
      flash[:notice] = 'Company data is not updated'
      redirect_to :back    
    end
  end

  private
  def company_params
      params.require(:company).permit(:name)
  end

  def company_update_params
      params.require(:company).permit(:name, :aws_api_key, :aws_api_secretkey, :aws_assoicate_tag, :addressline1, :addressline2, :city, :zipcode, :state)
  end

  def resolve_layout
    case action_name
    when "new","create"
      if !user_signed_in?
        "users"
      else
        "application"
      end
    else
      "application"
    end
  end
end
