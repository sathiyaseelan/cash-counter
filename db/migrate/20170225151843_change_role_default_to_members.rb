class ChangeRoleDefaultToMembers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :members, :role, :member
  end
end
