# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    protect_from_forgery

    before_action :authenticate_user!

    load_and_authorize_resource

    # in admin/base_controller.rb
    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    rescue_from CanCan::AccessDenied do |exception|
      flash[:warning] = exception.message
      redirect_to root_path
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
