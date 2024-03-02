class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :incomes_expenses

  def total_amount_by_month(year, month)
    incomes_expenses.total_amount_by_month(year, month)
  end
end
