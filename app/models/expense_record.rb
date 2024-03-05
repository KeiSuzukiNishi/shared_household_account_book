class ExpenseRecord < ApplicationRecord
  validates :year, presence: true
  validates :month, presence: true
  validates :ratio, presence: true
  validates :total_amount, presence: true
  validates :burden_amount, presence: true
  validates :difference, presence: true
  validates :income, presence: true
  
  belongs_to :user

  def to_param
    "#{id}-#{year}-#{month}"
  end

  def self.calculate_results(user_incomes)
    total_income = user_incomes.sum
    results = user_incomes.map { |income| (income.to_f / total_income.to_f * 100).round }
    results
  end

  def income
    self[:income]
  end
end
