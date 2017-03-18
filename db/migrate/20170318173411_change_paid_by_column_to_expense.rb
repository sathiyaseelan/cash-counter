class ChangePaidByColumnToExpense < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :expenses, column: :paid_by_id
    add_foreign_key :expenses, :members, column: :paid_by_id
  end
end
