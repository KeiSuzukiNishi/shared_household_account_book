class AddCategoryIdToIncomesExpenses < ActiveRecord::Migration[7.1]
  def change
    add_reference :incomes_expenses, :category, null: false, foreign_key: true
  end
end
