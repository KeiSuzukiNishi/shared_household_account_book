class ExpenseRecordsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
    @expense_records_by_month = {}

    grouped_records = ExpenseRecord.all.group_by { |record| [record.year, record.month] }.sort_by { |(year, month), _| [year, month] }.reverse

    grouped_records.each do |(year, month), records|
      begin
        date = Date.new(year, month)
        @expense_records_by_month[date] = records.map(&:expense_records_details).flatten 
      rescue ArgumentError
      end
    end
  end

  def new
    @expense_record = ExpenseRecord.new
    @users = User.all
    @year = params[:year].to_i || Time.now.year
    @month = params[:month].to_i || Time.now.month
    @total_expenses = @users.sum { |user| user.total_amount_by_month(@year, @month) }
    @results = []
  end

  def create
    @users = User.all
    @year = params[:expense_record][:year].to_i || Time.now.year
    @month = params[:expense_record][:month].to_i || Time.now.month
  
    @total_expenses = @users.sum { |user| user.total_amount_by_month(@year, @month) }
    @results = []
    
    user_incomes = params[:income].values.reject(&:blank?).map(&:to_i)
    # reject(&:blank?)があることで空欄を回避している。これを削除すると@resultsがNaNになる。
    total_income = user_incomes.sum
  
    @results = user_incomes.map { |income| (income.to_f / total_income.to_f * 100).round }
    
    if ExpenseRecord.exists?(year: @year, month: @month)
      redirect_to new_expense_record_path, alert: t('flash.expense_record_existed')
    else
      @expense_record = ExpenseRecord.new(year: @year, month: @month)  # ここで@expense_recordを定義
  
      @users.each_with_index do |user, index|
        @expense_record.expense_records_details.build(
          user: user,
          ratio: @results[index],
          total_amount: user.total_amount_by_month(@year, @month),
          burden_amount: @total_expenses * @results[index] / 100,
          difference: @total_expenses * @results[index] / 100 - (user.total_amount_by_month(@year, @month) * @results[index] / 100),
          income: user_incomes[index]
        )
      end
      
      if @expense_record.save
        redirect_to expense_records_path
      else
        render :new
      end
    end
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

  def edit
    @expense_record = ExpenseRecord.find(params[:id])
  end

  def update
    expense_record = ExpenseRecord.find(params[:id])
  
    @year = params[:expense_record][:year].to_i || Time.now.year
    @month = params[:expense_record][:month].to_i || Time.now.month
  
    expense_record.update(year: @year, month: @month)
  
    total_expenses = User.all.sum { |user| user.total_amount_by_month(@year, @month) }
  
    user_incomes = params[:income].values.map(&:to_i)
    total_income = user_incomes.sum
    total_income = 1 if total_income.zero?  # もしtotal_incomeが0なら、デフォルト値として1を設定する
    results = user_incomes.map { |income| (income.to_f / total_income.to_f * 100).round }
      
    expense_record.expense_records_details.each_with_index do |detail, index|
      user = detail.user
  
      detail.update(
        ratio: results[index],
        total_amount: user.total_amount_by_month(@year, @month),
        burden_amount: total_expenses * results[index] / 100,
        difference: total_expenses * results[index] / 100 - (user.total_amount_by_month(@year, @month) * results[index] / 100),
        income: user_incomes[index]
      )
    end
  
    redirect_to expense_record_path(expense_record)
  end
  
  def destroy
    @expense_record = ExpenseRecord.find_by(id: params[:id])
    if @expense_record
      @expense_record.destroy
      redirect_to expense_records_path, notice: "Expense Record was successfully destroyed."
    else
      redirect_to expense_records_path, alert: "Expense Record not found."
    end
  end

  private

  def expense_record_params
    params.require(:expense_record).permit(:year, :month, :ratio, :total_amount, :burden_amount, :difference, :income)
  end
end