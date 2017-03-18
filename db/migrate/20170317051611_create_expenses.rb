class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.text :description
      t.decimal :amount
      t.datetime :paid_on
      t.references :paid_by, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
