class ChartsController < ApplicationController
    def pie_chart_monthly
      # フォームからのパラメータで対象年月を取得（デフォルトは現在の年月）
      selected_year = params[:selected_year].presence || Date.today.year
      selected_month = params[:selected_month].presence || Date.today.month
  
      # 対象年月の月初から月末までの範囲を取得
      start_date = Date.new(selected_year.to_i, selected_month.to_i, 1)
      end_date = start_date.end_of_month
  
      # 対象期間の支出データを取得
      @monthly_expenses = IncomesExpense.expenses
                                        .where(dealt_on: start_date..end_date)
                                        .group_by_month(:dealt_on, format: '%Y-%m')
                                        .sum(:amount)
  
      # 各項目ごとの合計金額とパーセンテージを計算
      @total_amount_by_category = IncomesExpense.expenses
                                                  .where(dealt_on: start_date..end_date)
                                                  .group(:category_id)
                                                  .sum(:amount)
  
      @total_amount = @total_amount_by_category.values.sum
      @percentages_by_category = @total_amount_by_category.transform_values { |amount| (amount.to_f / @total_amount * 100).round(2) }
  
      # カテゴリごとの支出データを取得
      @data = IncomesExpense.expenses
                            .joins(:category)
                            .where(dealt_on: start_date..end_date)
                            .group("categories.name")
                            .sum(:amount)

       
        @expenses_by_month = IncomesExpense.expenses
                                            .where(dealt_on: start_date..end_date)
                                            .sum(:amount)
        
        @incomes_by_month = IncomesExpense.incomes
                                            .where(dealt_on: start_date..end_date)
                                            .sum(:amount)

        @differences_by_month = @incomes_by_month.to_i - @expenses_by_month.to_i
    
    end

    def pie_chart_yearly
        # フォームからのパラメータで対象年を取得（デフォルトは現在の年月）
        selected_year = params[:selected_year].presence || Date.today.year
        start_date = Date.new(selected_year.to_i, 1, 1)
        end_date = Date.new(selected_year.to_i, 12, 31)
    
        # 対象期間の支出データを取得
        @yearly_expenses = IncomesExpense.expenses
                                          .where(dealt_on: start_date..end_date)
                                          .group_by_year(:dealt_on, format: '%Y-%m')
                                          .sum(:amount)
    
        # 各項目ごとの合計金額とパーセンテージを計算
        @total_amount_by_category = IncomesExpense.expenses
                                                    .where(dealt_on: start_date..end_date)
                                                    .group(:category_id)
                                                    .sum(:amount)
    
        @total_amount = @total_amount_by_category.values.sum
        @percentages_by_category = @total_amount_by_category.transform_values { |amount| (amount.to_f / @total_amount * 100).round(2) }
    
        # カテゴリごとの支出データを取得
        @data = IncomesExpense.expenses
                              .joins(:category)
                              .where(dealt_on: start_date..end_date)
                              .group("categories.name")
                              .sum(:amount)
  
         
          @expenses_by_year = IncomesExpense.expenses
                                              .where(dealt_on: start_date..end_date)
                                              .sum(:amount)
          
          @incomes_by_year = IncomesExpense.incomes
                                              .where(dealt_on: start_date..end_date)
                                              .sum(:amount)
  
          @differences_by_year = @incomes_by_year.to_i - @expenses_by_year.to_i
      
    end

    def column_chart_monthly
        # フォームからのパラメータで対象年月を取得（デフォルトは現在の年月）
        selected_year = params[:selected_year].presence || Date.today.year
    
        # フォームからのパラメータで開始月と終了月を取得
        start_month = params[:start_month].presence || 1
        end_month = params[:end_month].presence || 12
    
        # 対象期間の収入データを取得
        @monthly_incomes = IncomesExpense.incomes
                                         .select("EXTRACT(YEAR FROM dealt_on) AS year, EXTRACT(MONTH FROM dealt_on) AS month, SUM(amount) AS total_amount")
                                         .where("EXTRACT(YEAR FROM dealt_on) = ? AND EXTRACT(MONTH FROM dealt_on) BETWEEN ? AND ?", selected_year, start_month, end_month)
                                         .group("year, month")
        
        # 対象期間の支出データを取得
        @monthly_expenses = IncomesExpense.expenses
                                          .select("EXTRACT(YEAR FROM dealt_on) AS year, EXTRACT(MONTH FROM dealt_on) AS month, SUM(amount) AS total_amount")
                                          .where("EXTRACT(YEAR FROM dealt_on) = ? AND EXTRACT(MONTH FROM dealt_on) BETWEEN ? AND ?", selected_year, start_month, end_month)
                                          .group("year, month")
    end

    def column_chart_yearly
        # フォームからのパラメータで開始年と終了年を取得（デフォルトは現在の年）
        start_year = params[:start_year].presence || Date.today.year
        end_year = params[:end_year].presence || Date.today.year

        # 対象期間の収入データを取得
        @yearly_incomes = IncomesExpense.incomes
                                        .select("EXTRACT(YEAR FROM dealt_on) AS year, EXTRACT(MONTH FROM dealt_on) AS month, SUM(amount) AS total_amount")
                                        .where("EXTRACT(YEAR FROM dealt_on) BETWEEN ? AND ?", start_year, end_year)
                                        .group("year, month")

        # 対象期間の支出データを取得
        @yearly_expenses = IncomesExpense.expenses
                                        .select("EXTRACT(YEAR FROM dealt_on) AS year, EXTRACT(MONTH FROM dealt_on) AS month, SUM(amount) AS total_amount")
                                        .where("EXTRACT(YEAR FROM dealt_on) BETWEEN ? AND ?", start_year, end_year)
                                        .group("year, month")
    end
end