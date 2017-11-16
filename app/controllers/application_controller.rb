class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def dashboard
  end

  def after_sign_in_path_for(resource)
    super
    sign_in(resource)
    resource.role_id = 2
    case current_user.role.name
      when 'Buyer'
        if current_user.subscription_id != nil and current_user.subscription_id != ''
         new_skynet_path
        else
         # plans_path
         new_skynet_path
        end
      when 'Manager'
        new_skynet_path
      when 'Admin'
        dashboard_dashboard_admin_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_up_path_for_plan(resource)
     root_path
  end

  def after_sign_up_path_for(resource)
    case current_user.role.name
      when 'Buyer'
        new_skynet_path
      when 'Manager'
        new_skynet_path
      when 'Admin'
        dashboard_dashboard_admin_path
    end
  end

  def load_skynet
    @skynets = current_user.company.skynets
    # @skynets = Skynet.find_by skynet_status.name: 'InQueue'
    if @skynets
      @skynets.each do |s|
        if s.skynet_status.name == 'InQueue' and s.task_id != nil
          skynetparams = s.task_id
          created = HTTParty.get('http://skynet2.azurewebsites.net/api/ProfitSourcing/GetTask/'+skynetparams, :headers => { 'Content-Type' => 'application/json', 'apikey' => 'bc6418e5-d86d-4822-bfee-e154cb145eb5' } )
          status = created['StatusMessage']
          outputurl = created['OutputFileUrl']
          s.statusmessage = status
          s.skynet_status_id = created['Status']
          s.outputfileurl = outputurl
          s.save
        end
      end
    end
  end

end
