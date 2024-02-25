class AddStartsAtAndEndsAtToIncomesExpenses < ActiveRecord::Migration[7.1]
  def change
    add_column :incomes_expenses, :starts_at, :datetime
    add_column :incomes_expenses, :ends_at, :datetime
  end
end
