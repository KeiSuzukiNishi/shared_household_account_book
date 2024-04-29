require 'rails_helper'

RSpec.describe '収支モデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context '収支の日付が空の場合' do
      it 'バリデーションに失敗する' do
        incomes_expense = FactoryBot.build(:incomes_expense, dealt_on: '')
        expect(incomes_expense).not_to be_valid
      end
    end
  
    context '収支種類が空の場合' do
      it 'バリデーションに失敗する' do
        incomes_expense = FactoryBot.build(:incomes_expense, income_expense_type: '')
        expect(incomes_expense).not_to be_valid
      end
    end
  
    context '会社が空の場合' do
      it 'バリデーションに失敗する' do
        incomes_expense = FactoryBot.build(:incomes_expense, company: '')
        expect(incomes_expense).not_to be_valid
      end
    end
  
    context '金額が空の場合' do
      it 'バリデーションに失敗する' do
        incomes_expense = FactoryBot.build(:incomes_expense, amount: '')
        expect(incomes_expense).not_to be_valid
      end
    end

    context '入力項目がすべて埋まっている場合' do
      it 'バリデーションに成功する' do
        incomes_expense = FactoryBot.build(:incomes_expense)
        expect(incomes_expense).to be_valid
      end
    end
  end
  
  describe "scopeの確認テスト" do
    before(:each) do
      @category = FactoryBot.create(:category)
    end
  
    describe "収支タイプの選択と表示" do
      it "収入と支出それぞれ登録した内容で表示" do
        expense = FactoryBot.create(:incomes_expense, income_expense_type: "支出", category: @category)
        income = FactoryBot.create(:incomes_expense, income_expense_type: "収入", category: @category)
        expect(IncomesExpense.expenses).to eq([expense])
        expect(IncomesExpense.incomes).to eq([income])
      end
    end
  end
end