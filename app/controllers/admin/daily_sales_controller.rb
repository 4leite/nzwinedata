module Admin
  class DailySalesController < Admin::ApplicationController

    def scoped_resource
      if current_user.has_role?(:global_admin)
        DailySale
      else
        DailySale.where(site_id: current_user.site_id)
      end
    end
  end
end
