class Category < ApplicationRecord
    validates :name, presence: true
    has_many :incomes_expenses
end
