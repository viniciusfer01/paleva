class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :cpf])   
  end

  def after_sign_in_path_for(resource)
    # return the path based on resource
    if resource.is_a?(User) ## && current_user.stores.nil?
      new_store_url
    elsif resource.is_a?(User) ## && current_user.stores.present?
      root_url # verify later
    else 
      return
    end
  end
end
