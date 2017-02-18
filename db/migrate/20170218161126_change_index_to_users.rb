class ChangeIndexToUsers < ActiveRecord::Migration[5.0]
  def change

    remove_index :users, :first_name
    add_index :users, :first_name,           unique: false
  end
end
