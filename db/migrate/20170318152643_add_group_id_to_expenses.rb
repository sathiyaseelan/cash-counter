class AddGroupIdToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_reference :expenses, :group, foreign_key: true
  end
end
