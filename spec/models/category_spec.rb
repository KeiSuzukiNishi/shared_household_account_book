require 'rails_helper'

RSpec.describe '項目モデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context '項目の名前が空文字の場合' do
       it 'バリデーションに失敗する' do
           category = FactoryBot.build(:category, name: '')
           expect(category).not_to be_valid
       end
    end
  end
end