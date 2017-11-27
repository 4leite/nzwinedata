class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  skip_before_action :require_no_authentication
  before_action :authorize_roles, only: [:create, :update]
  before_action :set_roles, only: [:new, :create]
  before_action :set_sites, only: [:new, :create]

  # GET /resource/sign_up
  def new
    if can? :new, User
      super
    else
      flash[:info] = 'Sign up is currently invite only, please contact us if you wish to participate.'
      redirect_to root_path
    end
  end

  # POST /resource
  def create
    if can? :new, User
      super
      puts "made it here"
    else
      flash[:info] = 'Sign up is currently invite only, please contact us if you wish to participate.'
      redirect_to root_path
    end
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
      user.permit( :email, { roles: [] }, :site_name, :site_id)
    end
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
  #
  def set_sites
    @sites = Site.all if current_user.has_role? :global_admin
  end
  
  def set_roles
    @roles = current_user.available_roles
  end

  def authorize_roles
    params[:user][:roles].reject{ |r| r.empty? }.each { |r| authorize!(r.to_sym, @user) } if params[:user][:roles]
  end
end
