class Category < ApplicationRecord
    has_and_belongs_to_many :incomes_expenses
end
