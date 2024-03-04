class ExpenseRecord < ApplicationRecord
  validates :year, presence: true
  validates :month, presence: true
  validates :ratio, presence: true
  validates :total_amount, presence: true
  validates :burden_amount, presence: true
  validates :difference, presence: true
  
  belongs_to :user

  def to_param
    "#{id}-#{year}-#{month}"
  end
end
