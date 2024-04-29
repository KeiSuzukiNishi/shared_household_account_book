require 'rails_helper'

RSpec.describe ExpenseRecord, type: :model do
  describe "CRUD機能" do
    it "新規割勘記録の作成" do
      expense_record = FactoryBot.create(:expense_record)
      expect(ExpenseRecord.count).to eq(1)
    end

    it "既存割勘記録の読み取り" do
      expense_record = FactoryBot.create(:expense_record)
      expect(ExpenseRecord.find(expense_record.id)).to eq(expense_record)
    end

    it "既存割勘記録の更新" do
      expense_record = FactoryBot.create(:expense_record)
      expense_record.update(year: 2023)
      expect(ExpenseRecord.find(expense_record.id).year).to eq(2023)
    end

    it "既存割勘記録の削除" do
      expense_record = FactoryBot.create(:expense_record)
      expense_record.destroy
      expect(ExpenseRecord.find_by(id: expense_record.id)).to be_nil
    end
  end
end