class CreateJoinTableIncomesExpensesCategories < ActiveRecord::Migration[7.1]
  def change
    create_join_table :incomes_expenses, :categories do |t|
      t.index [:incomes_expense_id, :category_id]
      t.index [:category_id, :incomes_expense_id]
    end
  end
end
