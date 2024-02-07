require "application_system_test_case"

class IncomesExpensesTest < ApplicationSystemTestCase
  setup do
    @incomes_expense = incomes_expenses(:one)
  end

  test "visiting the index" do
    visit incomes_expenses_url
    assert_selector "h1", text: "Incomes expenses"
  end

  test "should create incomes expense" do
    visit incomes_expenses_url
    click_on "New incomes expense"

    fill_in "Amount", with: @incomes_expense.amount
    fill_in "Company", with: @incomes_expense.company
    fill_in "Dealt on", with: @incomes_expense.dealt_on
    fill_in "Description", with: @incomes_expense.description
    fill_in "Image", with: @incomes_expense.image
    fill_in "Income expense type", with: @incomes_expense.income_expense_type
    fill_in "Remarks", with: @incomes_expense.remarks
    click_on "Create Incomes expense"

    assert_text "Incomes expense was successfully created"
    click_on "Back"
  end

  test "should update Incomes expense" do
    visit incomes_expense_url(@incomes_expense)
    click_on "Edit this incomes expense", match: :first

    fill_in "Amount", with: @incomes_expense.amount
    fill_in "Company", with: @incomes_expense.company
    fill_in "Dealt on", with: @incomes_expense.dealt_on
    fill_in "Description", with: @incomes_expense.description
    fill_in "Image", with: @incomes_expense.image
    fill_in "Income expense type", with: @incomes_expense.income_expense_type
    fill_in "Remarks", with: @incomes_expense.remarks
    click_on "Update Incomes expense"

    assert_text "Incomes expense was successfully updated"
    click_on "Back"
  end

  test "should destroy Incomes expense" do
    visit incomes_expense_url(@incomes_expense)
    click_on "Destroy this incomes expense", match: :first

    assert_text "Incomes expense was successfully destroyed"
  end
end
