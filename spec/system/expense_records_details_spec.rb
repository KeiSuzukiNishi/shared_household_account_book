require 'rails_helper'

RSpec.describe ExpenseRecordsDetail, type: :model do
  describe "CRUD機能" do
    it "割勘詳細の作成" do
      expense_records_detail = FactoryBot.create(:expense_records_detail)
      expect(ExpenseRecordsDetail.count).to eq(1)
    end

    it "既存割勘詳細の読み取り" do
      expense_records_detail = FactoryBot.create(:expense_records_detail)
      expect(ExpenseRecordsDetail.find(expense_records_detail.id)).to eq(expense_records_detail)
    end

    it "既存割勘詳細の更新" do
      expense_records_detail = FactoryBot.create(:expense_records_detail)
      expense_records_detail.update(income: 1000)
      expect(ExpenseRecordsDetail.find(expense_records_detail.id).income).to eq(1000)
    end

    it "既存割勘詳細の削除" do
      expense_records_detail = FactoryBot.create(:expense_records_detail)
      expense_records_detail.destroy
      expect(ExpenseRecordsDetail.find_by(id: expense_records_detail.id)).to be_nil
    end
  end
end