class RenameGroupUsersToMembers < ActiveRecord::Migration[5.0]
  def change
    rename_table :groups_users, :members
  end
end
