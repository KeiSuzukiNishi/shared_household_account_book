class IncomesExpense < ApplicationRecord
    validates :dealt_on, presence: true
    validates :income_expense_type, presence: true
    validates :company, presence: true
    validates :amount, presence: true

    enum income_expense_type: { "収入": 0, "支出": 1 }
    has_one_attached :image

    belongs_to :category

    def start_date
        starts_at || dealt_on
    end

    def end_date
        ends_at || dealt_on
    end

    def start_time
        dealt_on.to_time
    end
end
