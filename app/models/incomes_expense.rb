class IncomesExpense < ApplicationRecord
    validates :dealt_on, presence: true
    validates :income_expense_type, presence: true
    validates :company, presence: true
    validates :amount, presence: true

    enum income_expense_type: { "収入": 0, "支出": 1 }
    scope :expenses, -> { where(income_expense_type: "支出") }
    scope :incomes, -> { where(income_expense_type: "収入") }

    has_one_attached :image

    belongs_to :category
    belongs_to :user

    def start_date
        starts_at || dealt_on
    end

    def end_date
        ends_at || dealt_on
    end

    def self.total_amount_by_month(year, month)
        where("extract(year from dealt_on) = ? AND extract(month from dealt_on) = ?", year, month)
          .sum(:amount)
    end
end
