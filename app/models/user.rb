class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  belongs_to :site

  ROLES = %i[guest dev global_admin site_admin miner]

  def roles=(roles)
    roles = [*roles].map { |r| r.to_sym }
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end
    
  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role?(role)
    roles.include?(role)
  end

  def ability
    @ability ||= Ability.new(self)
  end
  
  delegate :can?, :cannot?, :to => :ability

  def available_roles
    ROLES.select{ |r| can? r.to_sym, self }.map { |r| r }
  end
  
  def to_s
    email
  end

end
