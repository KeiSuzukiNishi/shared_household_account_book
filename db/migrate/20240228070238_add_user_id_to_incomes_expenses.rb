class AddUserIdToIncomesExpenses < ActiveRecord::Migration[6.0]
  def change
    add_reference :incomes_expenses, :user, null: false, foreign_key: true, default: 1
  end
end