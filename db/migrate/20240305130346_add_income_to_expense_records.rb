class AddIncomeToExpenseRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :expense_records, :income, :integer
  end
end
