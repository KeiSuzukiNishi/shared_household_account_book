class AddUserIdToExpenseRecordsDetails < ActiveRecord::Migration[7.1]
  def change
    add_reference :expense_records_details, :user, foreign_key: true
  end
end