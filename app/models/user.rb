class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :incomes_expenses
  has_many :expense_records_details
  accepts_nested_attributes_for :expense_records_details

  def total_amount_by_month(year, month)
    incomes_expenses.total_amount_by_month(year, month)
  end
end