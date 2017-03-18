class RenameExpenseCategoryTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :expense_categories, :expenses_categories
  end
end
