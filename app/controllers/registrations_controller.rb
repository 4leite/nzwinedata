class RegistrationsController < Devise::RegistrationsController
  before_action :authorize_roles, only: [:create, :update]

  def new
    flash[:info] = 'Registrations are not open.'
    redirect_to root_path
  end

  def create
    flash[:info] = 'Registrations are not open.'
    redirect_to root_path
  end

  protected

  def authorize_roles
    params[:user][:roles].select! { |r| r.present? }
    params[:user][:roles].each { |r| authorize!(r.to_sym, @user) }
  end

end
