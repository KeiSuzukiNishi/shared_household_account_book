require 'rails_helper'

RSpec.describe "項目モデル", type: :model do
  describe "CRUD機能" do
    it "新規項目作成" do
      category = FactoryBot.create(:category)
      expect(Category.count).to eq(1)
    end

    it "既存項目の読み取り" do
      category = FactoryBot.create(:category)
      expect(Category.find(category.id)).to eq(category)
    end

    it "既存項目の更新" do
      category = FactoryBot.create(:category)
      category.update(name: "Updated Name")
      expect(Category.find(category.id).name).to eq("Updated Name")
    end

    it "既存項目の削除" do
      category = FactoryBot.create(:category)
      category.destroy
      expect(Category.find_by(id: category.id)).to be_nil
    end
  end
end