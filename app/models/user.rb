class User < ApplicationRecord
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :incomes_expenses
  has_many :expense_record_details, inverse_of: :user
  accepts_nested_attributes_for :expense_record_details

  def total_amount_by_month(year, month)
    incomes_expenses.total_amount_by_month(year, month)
  end
end