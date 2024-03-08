class ExpenseRecordsController < ApplicationController
  def index
    @users = User.all
    @expense_records_by_month = {}

    ExpenseRecord.all.group_by { |record| [record.year, record.month] }.each do |(year, month), records|
      @expense_records_by_month[Date.new(year, month)] = records
    end
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
    @year = params[:expense_record][:year].to_i || Time.now.year
    @month = params[:expense_record][:month].to_i || Time.now.month
    @total_expenses = @users.sum { |user| user.total_amount_by_month(@year, @month) }
    @results = []

    
    user_incomes = params[:income].values.map(&:to_i) 
    total_income = user_incomes.sum

    @results = user_incomes.map { |income| (income.to_f / total_income.to_f * 100).round }
    # ここまでできてる。下記のratioがexpenserecordモデルのカラムにないからエラーが出る。もはやdetailsを使用せずに普通にexenserecordにカラムを追加してやればいいのでは？ 
    # binding.pry
    @users.each_with_index do |user, index|
      ExpenseRecord.create!(
        user: user,
        year: @year,
        month: @month,
        ratio: @results[index],
        total_amount: user.total_amount_by_month(@year, @month),
        burden_amount: @total_expenses * @results[index] / 100,
        difference: @total_expenses * @results[index] / 100 - (user.total_amount_by_month(@year, @month) * @results[index] / 100),
        income: user_incomes[index]
      )
    end

    redirect_to expense_records_path
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
    @expense_record = ExpenseRecord.find(params[:id])

    if @expense_record.update(expense_record_params)
      redirect_to expense_record_path(@expense_record)
    else
      render :edit
    end
  end
  
  private

  def expense_record_params
    params.require(:expense_record).permit(:year, :month, user_incomes_attributes: [:id, :income])
  end
end