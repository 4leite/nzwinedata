class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_locale

  def after_sign_in_path_for(resource)
    daily_sales_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to root_path
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end


end
