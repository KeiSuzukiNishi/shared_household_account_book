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

        @expense_record = ExpenseRecord.find_by(user: @users.first, year: @year, month: @month)

         if @expense_record.present?
          @users.each_with_index do |user, index|
            ExpenseRecord.create!(
              user: user,
              year: @year,
              month: @month,
              ratio: @results[index],
              total_amount: user.total_amount_by_month(@year, @month),
              burden_amount: @total_expenses * @results[index] / 100,
              difference: @total_expenses * @results[index] / 100 - (user.total_amount_by_month(@year, @month) * @results[index] / 100)
            )
          end
        end
      else
        @results = [] 
      end
      render :index
  end

  def new
    @users = User.all
    @year = params[:year].to_i || Time.now.year
    @month = params[:month].to_i || Time.now.month
    @total_expenses = @users.sum { |user| user.total_amount_by_month(@year, @month) }
    @results = []
  end

  def create
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

      @users.each_with_index do |user, index|
        ExpenseRecord.create!(
          user: user,
          year: @year,
          month: @month,
          ratio: @results[index],
          total_amount: user.total_amount_by_month(@year, @month),
          burden_amount: @total_expenses * @results[index] / 100,
          difference: @total_expenses * @results[index] / 100 - (user.total_amount_by_month(@year, @month) * @results[index] / 100)
        )
      end
    else
      @results = []
    end
    redirect_to expense_record_path(ExpenseRecord.last)
  end
        
  def show
    @expense_record = ExpenseRecord.find(params[:id])
  
    @users = User.all
    @year = @expense_record.year
    @month = @expense_record.month
    @total_expenses = @users.sum { |user| user.total_amount_by_month(@year, @month) }
  
    @results = [] 
  
    
    render :show
  end
  
end