class AddRolesMaskToUsers < ActiveRecord::Migration
  def change
    add_column :users, :roles_mask, :integer
    add_index :users, :roles_mask
  end
end
