class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :belongs_to_group
      t.references :group_id, foreign_key: {to_table: :groups}
      t.timestamps
    end
  end
end
