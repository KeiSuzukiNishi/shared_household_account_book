class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :incomes_expenses
  has_many :expense_records, inverse_of: :user
  accepts_nested_attributes_for :expense_records

  def total_amount_by_month(year, month)
    incomes_expenses.total_amount_by_month(year, month)
  end
end