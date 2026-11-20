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
end
