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

end
