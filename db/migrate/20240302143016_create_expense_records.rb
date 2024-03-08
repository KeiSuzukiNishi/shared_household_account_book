class CreateExpenseRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_records do |t|
      t.references :user, foreign_key: true
      t.integer :year
      t.integer :month
      t.timestamps
    end
  end
end
