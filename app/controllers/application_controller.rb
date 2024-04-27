class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_locale
  

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    def set_locale
      I18n.locale = :ja
    end

    private

    def after_sign_in_path_for(resource_or_scope)
      incomes_expenses_path      
    end
  
    def after_sign_out_path_for(resource_or_scope)
      new_user_session_path
    end
end
