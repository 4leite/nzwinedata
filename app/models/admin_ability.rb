class AdminAbility < Ability

  def guest
    can :index, :home 
  end

  def miner
    guest
  end

  def site_admin
    super
    
    cannot :manage, DailySale
    can [:read, :destroy], DailySale, site_id: @user.site_id
  end

end
