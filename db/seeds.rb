# ユーザーを4人作成
4.times do |n|
    user = User.find_or_create_by!(email: "user#{n+1}@example.com") do |u|
      u.name = "user#{n+1}"
      u.password = "password123"
      u.password_confirmation = "password123"
    end
    puts "User #{user.email} created!"
  end
  
  # 管理者を2人作成
  2.times do |n|
    admin = User.find_or_create_by!(email: "admin#{n+1}@example.com") do |a|
      a.name = "admin#{n+1}"
      a.password = "password123"
      a.password_confirmation = "password123"
      a.admin = true # 管理者権限を付与
    end
    puts "Admin #{admin.email} created!"
  end
  
  # 項目を10個作成
  10.times do |n|
    category = Category.find_or_create_by!(name: "category#{n+1}")
    puts "Category #{category.name} created!"
  end
  
  # 収支を50個作成
  100.times do |n|
    dealt_on = Faker::Date.between(from: 1.year.ago, to: Date.today)
    income_expense_type = ["収入", "支出"].sample
    company = Faker::Company.name
    amount = rand(100..50000)
    category_id = Category.pluck(:id).sample
    user_id = User.pluck(:id).sample
  
    incomes_expense = IncomesExpense.create!(
      dealt_on: dealt_on,
      income_expense_type: income_expense_type,
      company: company,
      amount: amount,
      category_id: category_id,
      user_id: user_id
    )
    puts "IncomesExpense #{incomes_expense.id} created!"
  end
  
  # 割勘記録を12個作成
  12.times do |n|
    date = Date.today - 1.year + n.months
    expense_record = ExpenseRecord.find_or_create_by!(
      year: date.year,
      month: date.month
    )
    puts "ExpenseRecord #{expense_record.id} created for #{date.strftime('%Y-%m')}"
  end
  
  # 割勘記録詳細を12個作成
  # ユーザーをランダムに選択する際の確率を設定するための配列
  user_probabilities = [0.3, 0.2, 0.1, 0.1, 0.1, 0.1, 0.05, 0.05]
  
  users = User.all
  
  # 仮のレコードのIDを保持する配列を初期化
  temporary_record_ids = []
  
  12.times do |n|
    date = Date.today - 1.year + n.months
    expense_record = ExpenseRecord.find_or_create_by!(
      year: date.year,
      month: date.month
    )
  
    # 当月の全ユーザーの合計収入金額を初期化
    total_income_of_month = 0
  
    # 同じ月に2〜6人のユーザーをランダムに選択
    num_users = rand(2..6)
    selected_users = users.sample(num_users, random: Random.new(user_probabilities.hash))
  
    selected_users.each do |user|
      # ランダムな収入金額を設定（15万円〜30万円）
      income = rand(150000..300000)
      total_income_of_month += income
  
      temporary_record = ExpenseRecordsDetail.create!(
        expense_record: expense_record,
        user: user,
        ratio: 0,
        total_amount: 0,
        burden_amount: 0,
        difference: 0,
        income: income
      )
  
      # 仮のレコードのIDを配列に追加
      temporary_record_ids << temporary_record.id
    end
  
    selected_users.each do |user|
      # 合計支出金額のランダムな設定
      total_amount = rand(50000..200000)
  
      # 各ユーザーの収入に対するratioを計算
      user_income = ExpenseRecordsDetail.where(expense_record: expense_record, user: user).pluck(:income).first
      user_ratio = user_income.to_f / total_income_of_month.to_f
  
      # 負担金額を計算
      burden_amount = (user_ratio * total_amount).round
  
      # 差額を計算
      difference = total_amount - burden_amount
  
      user_ratio = (user_ratio * 100).round
  
      # 割り勘記録詳細を作成
      ExpenseRecordsDetail.create!(
        expense_record: expense_record,
        user: user,
        ratio: user_ratio,
        total_amount: total_amount,
        burden_amount: burden_amount,
        difference: difference,
        income: user_income
      )
    end
  
    # 仮のレコードを削除
    ExpenseRecordsDetail.where(id: temporary_record_ids).destroy_all
  
    puts "ExpenseRecord #{expense_record.id} created for #{date.strftime('%Y-%m')} with #{num_users} users"
  end
  