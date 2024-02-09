class IncomesExpensesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_incomes_expense, only: %i[ show edit update destroy ]

  # GET /incomes_expenses or /incomes_expenses.json
  def index
    @incomes_expenses = IncomesExpense.all
  end

  # GET /incomes_expenses/1 or /incomes_expenses/1.json
  def show
  end

  # GET /incomes_expenses/new
  def new
    @incomes_expense = IncomesExpense.new
  end

  # GET /incomes_expenses/1/edit
  def edit
  end

  # POST /incomes_expenses or /incomes_expenses.json
  def create
    @incomes_expense = IncomesExpense.new(incomes_expense_params)

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

  # PATCH/PUT /incomes_expenses/1 or /incomes_expenses/1.json
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

  # DELETE /incomes_expenses/1 or /incomes_expenses/1.json
  def destroy
    @incomes_expense.destroy!

    respond_to do |format|
      format.html { redirect_to incomes_expenses_url, notice: t('shared_book.incomes_expenses_destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incomes_expense
      @incomes_expense = IncomesExpense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def incomes_expense_params
      params.require(:incomes_expense).permit(:dealt_on, :income_expense_type, :company, :description, :remarks, :amount, :image)
    end
end
