class ExpenseRecordsController < ApplicationController
  def index
      @users = User.all
      @year = params[:year].to_i || Time.now.year
      @month = params[:month].to_i || Time.now.month
      @total_expenses = @users.sum { |user| user.total_amount_by_month(@year, @month) }
      
      if params[:user_incomes]
        user_incomes = params[:user_incomes].values.map(&:to_i)
        total_income = user_incomes.sum
        
        @results = user_incomes.map do |income|
          (income.to_f / total_income.to_f * 100).round
        end
      else
        @results = [] 
      end
      render :index
  end
        

end