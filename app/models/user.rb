class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
	 :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :confirmable

  validate :password_complexity

  belongs_to :site, inverse_of: :users 
  accepts_nested_attributes_for :site

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
    ROLES.without(:guest, :dev).select{ |r| can? r.to_sym, self }.map { |r| r }
  end

  def site_name
    site.try(:name)
  end

  def site_name=(name)
    self.site = Site.find_or_create_by(name: name) if name.present?
  end

  def to_s
	 email
  end

  def password_complexity
	 if password.present?
		if !password.match(/^(?=.*[a-z])(?=.*[0-9])/) 
		  errors.add :password, "Password must contain a mixture of letters and numbers"
		end
	 end
  end

  def password_required?
	 # Password is required if it is being set, but not for new records
	 if !persisted? 
		false
	 else
		!password.nil? || !password_confirmation.nil?
	 end
  end

  def password_match?
	 self.errors[:password] << "can't be blank" if password.blank?
	 self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
	 self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
	 password == password_confirmation && !password.blank?
  end

  # new function to set the password without knowing the current 
  # password used in our confirmation controller. 
  def attempt_set_password(params)
	 p = {}
	 p[:password] = params[:password]
	 p[:password_confirmation] = params[:password_confirmation]
	 update_attributes(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
	 self.encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore. 
  # Instead you should use `pending_any_confirmation`.  
  def only_if_unconfirmed
	 pending_any_confirmation {yield}
  end
end
