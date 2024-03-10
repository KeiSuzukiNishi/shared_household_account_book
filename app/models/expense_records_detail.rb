class ExpenseRecordsDetail < ApplicationRecord
    belongs_to :expense_record
    validates :ratio, presence: true
    validates :total_amount, presence: true
    validates :burden_amount, presence: true
    validates :difference, presence: true
    validates :income, presence: true
  end