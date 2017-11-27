class UsersController < ApplicationController
  load_and_authorize_resource

  def destroy
    @user = User.find(params[:id])
    site = @user.site
    @user.destroy

    if @user.destroy
      redirect_to site_path(site), notice: "User deleted."
    end
  end
end
