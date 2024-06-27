class IncomesExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_incomes_expense, only: %i[ show edit update destroy ]

  def index
    @incomes_expenses = IncomesExpense.all.page(params[:page]).order(dealt_on: :desc)
    @categories = Category.all
  end

  def show
    @categories = Category.all
  end


  def new
    @incomes_expense = IncomesExpense.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @incomes_expense = IncomesExpense.new(incomes_expense_params)
    @incomes_expense.user = current_user
    @categories = Category.all

    respond_to do |format|
      if @incomes_expense.save
        format.html { redirect_to incomes_expense_url(@incomes_expense), notice: t('shared_book.incomes_expenses_created') }
        format.json { render :show, status: :created, location: @incomes_expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @incomes_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def calendar
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.today
    @incomes_expenses = IncomesExpense.where(dealt_on: @start_date.beginning_of_month..@start_date.end_of_month)
    @categories = Category.all
    render 'calendar'
  end

  def update
    respond_to do |format|
      if @incomes_expense.update(incomes_expense_params)
        format.html { redirect_to incomes_expense_url(@incomes_expense), notice: t('shared_book.incomes_expenses_updated') }
        format.json { render :show, status: :ok, location: @incomes_expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @incomes_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @incomes_expense.destroy!
    respond_to do |format|
      format.html { redirect_to incomes_expenses_url, notice: t('shared_book.incomes_expenses_destroyed') }
      format.json { head :no_content }
    end
  end

  def show_image
    @incomes_expense = IncomesExpense.find(params[:id])
    @image_url = url_for(@incomes_expense.image)
  end


  private
  
  def set_incomes_expense
    if params[:id] == "calendar"
      return
    end
    @incomes_expense = IncomesExpense.find(params[:id])
  end
  
    def incomes_expense_params
      params.require(:incomes_expense).permit(:dealt_on, :income_expense_type, :company, :description, :remarks, :amount, :image, :category_id)
    end
end
