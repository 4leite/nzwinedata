class Ability
  include CanCan::Ability

  def initialize(user)

    @user = user || User.new

    if @user.roles.blank?
      guest
    else
      @user.roles.each { |role| send role }
    end

	 can :manage, :home
  end

  def guest
    can :manage, :home
    can [:show, :create, :update, :destroy], User, id: @user.id
  end

  def miner
    nav_miner
    can :show, Site, id: @user.site_id
    can :manage, DailySale, site_id: @user.site_id
    guest
  end

  def site_admin

    nav_miner
    nav_admin
    can [:show, :update], Site, id: @user.site_id
    can [:miner, :site_admin, :create, :update, :destroy, :read], User, site_id: @user.site_id

    #can :manage, User, site_id: @user.site_id
    can [:read, :destroy], DailySale, site_id: @user.site_id

    guest
  end

  def global_admin
    can :manage, :all
  end

  def dev
    can :manage, :all
  end

  private

  def nav_miner
    can :mine, :navbar
  end

  def nav_admin
    can :admin, :navbar
  end

end
