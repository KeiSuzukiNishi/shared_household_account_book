FactoryBot.define do
  factory :incomes_expense do
    dealt_on { Faker::Date.between(from: '2022-01-01', to: '2024-04-16') }
    income_expense_type { ["収入", "支出"].sample }
    company { Faker::Company.name }
    amount { Faker::Number.decimal(l_digits: 2) }
    category { association :category } # ランダムなカテゴリを関連付ける
    user { association :user } # ランダムなユーザーを関連付ける
  end
end