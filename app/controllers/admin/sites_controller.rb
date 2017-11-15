module Admin
  class SitesController < Admin::ApplicationController

    def scoped_resource
      if current_user.has_role?(:global_admin)
        Site
      else
        Site.where(id: current_user.site_id)
      end
    end

  end
end
