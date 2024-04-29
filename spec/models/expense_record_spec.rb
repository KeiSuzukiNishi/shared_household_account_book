require 'rails_helper'

RSpec.describe '割勘記録モデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context '割勘記録の年が空文字の場合' do
       it 'バリデーションに失敗する' do
           expense_record = FactoryBot.build(:expense_record, year: '')
           expect(expense_record).not_to be_valid
       end
    end

    context '割勘記録の月が空文字の場合' do
       it 'バリデーションに失敗する' do
           expense_record = FactoryBot.build(:expense_record, month: '')
           expect(expense_record).not_to be_valid
       end
    end

    context '割勘記録の項目が全部入力されている場合' do
      it 'バリデーションに成功する' do
          expense_record = FactoryBot.build(:expense_record)
          expect(expense_record).to be_valid
      end
   end
  end
end