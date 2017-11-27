class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication

  load_and_authorize_resource class: User, param_method: :configure_sign_up_params

  before_action :configure_sign_up_params, only: [:new, :create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :authorize_roles, only: [:create, :update]

  before_action :set_sites_and_roles, only: [:new, :create]

  # GET /resource/sign_up
  def new
    build_resource(site_id: params[:site_id])
    yield resource if block_given?
    respond_with resource
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit( :email, { roles: [] }, :site_name, :site_id )
    end
  end

  def registrations_params
    params.require(:sign_up).permit(:email, { roles: [] }, :site_name, :site_id)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:roles])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def set_sites_and_roles
    @sites = Site.all if current_user.has_role? :global_admin
    @roles = current_user.available_roles
  end

  def authorize_roles
    params[:user][:roles].reject{ |r| r.empty? }.each{ |r| authorize!(r.to_sym, User) } if params[:user][:roles]
  end
end
