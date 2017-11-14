module Admin
  class UsersController < Admin::ApplicationController

    def scoped_resource
      if current_user.has_role?(:global_admin)
        User
      else
        User.where(site_id: current_user.site_id)
      end
    end
  end
end
