class AdminAbility
  include CanCan::Ability

  def initialize(user)
    
    @user = user || User.new

    unless @user.roles.blank?
      @user.roles.each { |role| send(role.to_sym) }
    end
  end

  def guest
  end

  def miner
  end

  def site_admin
    nav_miner
    nav_admin
    can [:show, :update], Site, id: @user.site_id
    can :manage, User, site_id: @user.site_id
    can [:show, :destroy], DailySale, site_id: @user.site_id
  end

  def global_admin
    can :manage, :all
  end

  def dev
    can :manage, :all
  end

  # abstract ability classes

  private

  def nav_miner
    can :mine, :navbar
  end
  def nav_admin
    can :admin, :navbar
  end

end
