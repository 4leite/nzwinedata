class AddRolesMaskToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :roles_mask, :integer, null: false, default: 0
    add_index :users, :roles_mask
  end
end
