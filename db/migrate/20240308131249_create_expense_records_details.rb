class CreateExpenseRecordsDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_records_details do |t|
      t.references :expense_record, foreign_key: true
      t.decimal :ratio
      t.integer :total_amount
      t.integer :burden_amount
      t.integer :difference
      t.integer :income
      t.timestamps
    end
  end
end
