require "test_helper"

class IncomesExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @incomes_expense = incomes_expenses(:one)
  end

  test "should get index" do
    get incomes_expenses_url
    assert_response :success
  end

  test "should get new" do
    get new_incomes_expense_url
    assert_response :success
  end

  test "should create incomes_expense" do
    assert_difference("IncomesExpense.count") do
      post incomes_expenses_url, params: { incomes_expense: { amount: @incomes_expense.amount, company: @incomes_expense.company, dealt_on: @incomes_expense.dealt_on, description: @incomes_expense.description, image: @incomes_expense.image, income_expense_type: @incomes_expense.income_expense_type, remarks: @incomes_expense.remarks } }
    end

    assert_redirected_to incomes_expense_url(IncomesExpense.last)
  end

  test "should show incomes_expense" do
    get incomes_expense_url(@incomes_expense)
    assert_response :success
  end

  test "should get edit" do
    get edit_incomes_expense_url(@incomes_expense)
    assert_response :success
  end

  test "should update incomes_expense" do
    patch incomes_expense_url(@incomes_expense), params: { incomes_expense: { amount: @incomes_expense.amount, company: @incomes_expense.company, dealt_on: @incomes_expense.dealt_on, description: @incomes_expense.description, image: @incomes_expense.image, income_expense_type: @incomes_expense.income_expense_type, remarks: @incomes_expense.remarks } }
    assert_redirected_to incomes_expense_url(@incomes_expense)
  end

  test "should destroy incomes_expense" do
    assert_difference("IncomesExpense.count", -1) do
      delete incomes_expense_url(@incomes_expense)
    end

    assert_redirected_to incomes_expenses_url
  end
end
