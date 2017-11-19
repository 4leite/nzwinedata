module Admin
  class UsersController < Admin::ApplicationController
    before_action :authorize_roles, only: [:create, :update]

    def scoped_resource
      if current_user.has_role?(:global_admin)
        User
      else
        User.where(site_id: current_user.site_id)
      end
    end

    protected

    def authorize_roles
      params[:user][:roles].select! { |r| r.present? }
      params[:user][:roles].each { |r| authorize!(r.to_sym, @user) }
    end
  end
end
