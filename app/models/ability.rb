class Ability
  include CanCan::Ability


  def initialize(user)
    
    @user = user || User.new

    if @user.roles.blank?
      can :index, :home 
    else
      @user.roles.each { |role| send(role.to_sym) }
    end
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

  def global_admin
    nav_miner
    nav_admin
    can :manage, :all
    guest
  end

  def site_admin
    nav_miner
    nav_admin
    can [:show, :update], Site, id: @user.site_id
    can :manage, User, site_id: @user.site_id
    can :manage, DailySale, site_id: @user.site_id
    guest
  end

  def dev
    can :manage, :all
  end

  # abstract ability classes

  private
  def nav_miner
    can :navbar, :administrate
  end
  def nav_admin
    can :navbar, :administrate
  end

end
