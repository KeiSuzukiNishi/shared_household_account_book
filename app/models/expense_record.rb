class ExpenseRecord < ApplicationRecord
  validates :year, presence: true
  validates :month, presence: true
  # validate :income_present_for_each_user
  
  has_many :expense_records_details, inverse_of: :expense_record, dependent: :destroy
  accepts_nested_attributes_for :expense_records_details

  def calculate_results(user_incomes)
    total_income = user_incomes.sum(&:income).to_f
    user_incomes.map { |ui| (ui.income / total_income * 100).round }
  end

  private

  # def income_present_for_each_user
  #   User.all.each do |user|
  #     if self.expense_records_details.find_by(user_id: user.id).blank?
  #       errors.add(:base, "#{user.name} の年収を入力してください")
  #     end
  #   end
  # end
end