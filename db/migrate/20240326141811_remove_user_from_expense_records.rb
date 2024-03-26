class RemoveUserFromExpenseRecords < ActiveRecord::Migration[7.1]
  def change
    remove_reference :expense_records, :user, foreign_key: true
  end
end
