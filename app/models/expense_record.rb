class ExpenseRecord < ApplicationRecord
  validates :year, presence: true
  validates :month, presence: true

  belongs_to :user

  def to_param
    "#{id}-#{year}-#{month}"
  end

  def calculate_results(user_incomes)
    total_income = user_incomes.sum(&:income).to_f
    user_incomes.map { |ui| (ui.income / total_income * 100).round }
  end
end