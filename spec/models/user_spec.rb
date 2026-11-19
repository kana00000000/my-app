require "rails_helper"

RSpec.describe User, type: :model do
  it "名前・メールアドレス・パスワードがあれば有効" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "名前がなければ無効" do
    user = FactoryBot.build(:user, name: "")
    expect(user).not_to be_valid
  end
end
