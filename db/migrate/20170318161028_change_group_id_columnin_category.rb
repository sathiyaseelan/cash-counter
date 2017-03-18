class ChangeGroupIdColumninCategory < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :group_id_id, :group_id
  end
end
