# # ユーザーを4人作成
# 4.times do |n|
#     user = User.create!(
#         name: "user#{n+1}",
#         email: "user#{n+1}@example.com",
#         password: "password123", 
#         password_confirmation: "password123" 
#     )
#     puts "User #{user.email} created!"
# end

# # 管理者を2人作成
# 2.times do |n|
# admin = User.create!(
#     name: "admin#{n+1}",
#     email: "admin#{n+1}@example.com",
#     password: "password123", 
#     password_confirmation: "password123", 
#     admin: true # 管理者権限を付与
#     )
#     puts "Admin #{admin.email} created!"
# end

# # 項目を10個作成
# 10.times do |n|
#     category = Category.create!(
#     name: "category#{n+1}"
#     )
#     puts "Category #{category.name} created!"
# end

# # 収支を50個作成
# 100.times do |n|
#     dealt_on = Faker::Date.between(from: 1.year.ago, to: Date.today)
#     income_expense_type = ["収入", "支出"].sample
#     company = Faker::Company.name
#     amount = rand(100..50000)
#     category_id = Category.pluck(:id).sample
#     user_id = User.pluck(:id).sample

#     incomes_expense = IncomesExpense.create!(
#         dealt_on: dealt_on,
#         income_expense_type: income_expense_type,
#         company: company,
#         amount: amount,
#         category_id: category_id,
#         user_id: user_id
#     )
#     puts "IncomesExpense #{incomes_expense.id} created!"
# end

# # 割勘記録を12個作成
# 12.times do |n|
#     date = Date.today - 1.year + n.months
#     expense_record = ExpenseRecord.create!(
#       year: date.year,
#       month: date.month
#     )
#     puts "ExpenseRecord #{expense_record.id} created for #{date.strftime('%Y-%m')}"
# end

# 割勘記録詳細を12個作成
# ユーザーをランダムに選択する際の確率を設定するための配列
user_probabilities = [0.3, 0.2, 0.1, 0.1, 0.1, 0.1, 0.05, 0.05]

users = User.all

12.times do |n|
    date = Date.today - 1.year + n.months
    expense_record = ExpenseRecord.create!(
      year: date.year,
      month: date.month
    )
    
    # 同じ月に2〜6人のユーザーをランダムに選択
    num_users = rand(2..6)
    selected_users = users.sample(num_users, random: Random.new(user_probabilities.hash))
    
    # 合計支出金額のランダムな設定
    total_amount = rand(50000..200000)

    # 当月の全ユーザーの合計収入金額を計算しつつ、各ユーザーの収入を設定
    total_income_of_month = 0
    selected_users.each do |user|
      # ランダムな収入金額を設定（15万円〜30万円）
      income = rand(150000..300000)
      total_income_of_month += income
      
      # 各ユーザーの収入に対するratioを計算
      user_ratio = income.to_f / total_income_of_month.to_f
      
      burden_amount = (total_amount * user_ratio).round
      difference = total_amount - burden_amount
      
      ExpenseRecordsDetail.create!(
        expense_record: expense_record,
        user: user,
        ratio: user_ratio,
        total_amount: total_amount,
        burden_amount: burden_amount,
        difference: difference,
        income: income
      )
    end
    
    puts "ExpenseRecord #{expense_record.id} created for #{date.strftime('%Y-%m')} with #{num_users} users"
end