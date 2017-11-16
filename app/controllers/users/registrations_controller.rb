class Users::RegistrationsController < Devise::RegistrationsController
  # layout "users", only: [:new, :create]
  layout :resolve_layout
  # before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    # self.resource = resource_class.new(sign_up_params)
    # store_location_for(resource, params[:redirect_to])
    super
  end

  # POST /resource
  def create
    
    super
    company_name = params[:user][:company][:name]
    company = Company.where(:name => company_name).first_or_create
    
    role_id = 2
    if company.users.count == 0
      role_id = 1
    else
      role_id = 2
    end
    resource.role_id = role_id
    resource.company_id = company.id

    if resource.save
      after_sign_up_path_for(resource)
    else
      return
    end
    
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # def after_sign_up_path_for(resource)
  #   super
  #   # sign_in(resource)
  #   signed_in_root_path(resource)
  # end

  # def after_update_path_for(resource)
  #   signed_in_root_path(resource)
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   byebug
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:eamil, :password, :password_confirmation])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
    def sign_up_params
      # params.require(:user).permit(:email, :password, :password_confirmation, :company_id, :role_id)
      params.require(:user).permit(:email, :password, :password_confirmation, company_attributes: [:name])
    end

    def get_skynet
      
    end


  def resolve_layout
    case action_name
    when "new", "create"
      "users"
    when "edit"
      "application"
    else
      "application"
    end
  end
end
