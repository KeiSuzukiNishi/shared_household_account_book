class ExpenseRecordsDetail < ApplicationRecord
    belongs_to :expense_record
    belongs_to :user
    # validates :ratio, presence: true
    # validates :total_amount, presence: true
    # validates :burden_amount, presence: true
    # validates :difference, presence: true
    validates :income, presence: true, numericality: { greater_than_or_equal_to: 0 }
  end