class Role < ApplicationRecord
  enum :name [ :global_admin, :site_admin ]

  belongs_to :user

  validates_uniqueness_of :user_role, scope %i[user_id, name]
  

end
