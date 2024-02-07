class CreateIncomesExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :incomes_expenses do |t|
      t.date :dealt_on
      t.integer :income_expense_type
      t.string :company
      t.text :description
      t.text :remarks
      t.bigint :amount
      t.binary :image

      t.timestamps
    end
  end
end
