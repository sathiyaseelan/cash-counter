class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string, default: 'user'


      #Update the existing users role
      User.all.each  do |user|
        user.role = 'user'
        user.save
      end
  end

end
