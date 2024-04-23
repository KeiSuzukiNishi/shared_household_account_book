require 'rails_helper'

RSpec.describe IncomesExpense, type: :system do
  describe "CRUD機能" do
    it "新規収支作成" do
      incomes_expense = FactoryBot.create(:incomes_expense)
      expect(IncomesExpense.count).to eq(1)
    end

    it "既存収支の読み取り" do
      incomes_expense = FactoryBot.create(:incomes_expense)
      expect(IncomesExpense.find(incomes_expense.id)).to eq(incomes_expense)
    end

    it "既存収支の更新" do
      incomes_expense = FactoryBot.create(:incomes_expense)
      incomes_expense.update(amount: 1000)
      expect(IncomesExpense.find(incomes_expense.id).amount).to eq(1000)
    end

    it "既存収支の削除" do
      incomes_expense = FactoryBot.create(:incomes_expense)
      incomes_expense.destroy
      expect(IncomesExpense.find_by(id: incomes_expense.id)).to be_nil
    end
  end
end
