class AddRolesMaskColumnToUsersTable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :roles_mask, default: 0
    end
  end
end
