class Ability
  include CanCan::Ability


  def initialize(user)
    
    @user = user || User.new

    if @user.roles.size === 0 
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
    can :show, Site, id: @user.site_id
    can :manage, DailySale, site_id: @user.site_id
    guest
  end

  def global_admin
    admin
    can :manage, :all
  end

  def site_admin
    admin
    can [:show, :update], Site, id: @user.site_id
    can :manage, User, site_id: @user.site_id
    can :manage, DailySale, site_id: @user.site_id
    guest
  end

  def dev
    can :manage, :all
  end

  # abstract ability classes

  def admin
    can :view, :administrate
  end

end
