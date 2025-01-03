class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_store_registration, if: :user_signed_in?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :cpf])   
  end

  def after_sign_in_path_for(resource)
    # return the path based on resource
    if resource.is_a?(Employee)
      root_path
    elsif resource.is_a?(User) && current_user.store.nil?
      new_store_url      
    else 
      root_path
    end
  end

  def authenticate_user_or_employee!
    unless user_signed_in? || employee_signed_in?
      redirect_to new_user_session_path, alert: 'Você precisa estar logado para acessar essa página.'
    end
  end

  private
  def check_store_registration
    if current_user.is_a?(User) && current_user.store.nil? && request.path != new_store_path && request.path !=  destroy_user_session_path && !(controller_name == 'stores' && action_name == 'create') 
      flash.keep(:alert) 
      flash.keep(:notice)
      redirect_to new_store_path, alert: 'Por favor, registre sua loja.'
    end
  end
end
