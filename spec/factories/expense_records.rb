FactoryBot.define do
  factory :expense_record do
    year { Faker::Date.between(from: 5.years.ago, to: Date.today).year }
    month { Faker::Date.between(from: 1.year.ago, to: Date.today).month }
  end
end