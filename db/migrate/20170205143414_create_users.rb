class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :first_name,         null: false, default: ""
      t.string :last_name,          null: false, default: ""
      t.string :mobile,             null: false, default: ""
      t.string :password_digest,    null: false, default: ""

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :mobile,               unique: true
    add_index :users, :first_name,           unique: true
  end
end
