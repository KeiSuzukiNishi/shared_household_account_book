json.extract! incomes_expense, :id, :dealt_on, :income_expense_type, :company, :description, :remarks, :amount, :image, :created_at, :updated_at
json.url incomes_expense_url(incomes_expense, format: :json)
