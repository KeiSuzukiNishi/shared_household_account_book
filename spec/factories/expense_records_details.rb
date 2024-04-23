FactoryBot.define do
    factory :expense_records_detail do
      income { Faker::Number.decimal(l_digits: 5, r_digits: 2) }
      association :expense_record
      association :user
    end
  end