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
  end

  def miner
    can :miner, :navbar
    can [:show, :update, :destroy], User, id: @user.id
    can :show, Site, id: @user.site_id
    can :manage, DailySale, site_id: @user.site_id
    guest
  end

  def site_admin

    can [:mine, :site, :admin], :navbar
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

end
