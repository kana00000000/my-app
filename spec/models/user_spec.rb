require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "名前・メールアドレス・パスワードがあれば有効" do
      expect(FactoryBot.build(:user)).to be_valid
    end

    describe "名前" do
      it "なければ無効" do
        user = FactoryBot.build(:user, name: "")
        expect(user).not_to be_valid
        expect(user.errors[:name]).to be_present
      end
    end

    describe "メールアドレス" do
      it "なければ無効" do
        user = FactoryBot.build(:user, email: "")
        expect(user).not_to be_valid
        expect(user.errors[:email]).to be_present
      end

      it "すでに使われているものは無効" do
        FactoryBot.create(:user, email: "same@example.com")
        user = FactoryBot.build(:user, email: "same@example.com")
        expect(user).not_to be_valid
        expect(user.errors[:email]).to be_present
      end
    end

    describe "パスワード" do
      it "なければ無効" do
        user = FactoryBot.build(:user, password: "")
        expect(user).not_to be_valid
        expect(user.errors[:password]).to be_present
      end
    end
  end

  describe "#stool_record_on" do
    let(:user) { FactoryBot.create(:user) }

    it "その日の記録があれば、その記録を返す" do
      record = FactoryBot.create(:stool_record, user: user, recorded_on: Date.new(2026, 11, 15))

      expect(user.stool_record_on(Date.new(2026, 11, 15))).to eq record
    end

    it "その日の記録がなければ、nilを返す" do
      expect(user.stool_record_on(Date.new(2026, 11, 15))).to be_nil
    end

    it "日付が空なら、nilを返す" do
      expect(user.stool_record_on(nil)).to be_nil
    end
  end
end
