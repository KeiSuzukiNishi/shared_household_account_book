class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_locale
    
    rescue_from CanCan::AccessDenied do |exception|
      redirect_to incomes_expenses_path, alert: "管理者以外アクセスできません。"
    end

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    def set_locale
      I18n.locale = :ja
    end

end
