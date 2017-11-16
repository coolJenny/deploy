class UsersController < ApplicationController
  layout 'application'
  # before_filter :authenticate_user!
  def edit
    @user = User.find(params[:id])
  end

  def plans
  end
  
  def new
    @user = User.new
    @company = Company.find(params[:company])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to company_path(@user.company_id)
    else
      flash[:notice] = 'User data is not updated'     
    end
  end

  def create
    @user = User.new(user_updateparams)
    if @user.save
      redirect_to company_path(@user.company_id)
    else
      flash[:notice] = 'User was not created.'
      @company = @user.company
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destory
    redirect_to company_path(@user.company_id)
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role_id)
  end

  def user_updateparams
    params.require(:user).permit(:email, :password, :password_confirmation, :role_id, :company_id)
  end
end
