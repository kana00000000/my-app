require "rails_helper"

RSpec.describe "排便記録", type: :system do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  before do
    driven_by(:rack_test)
    sign_in user
  end

  it "カレンダーの日付を押して登録すると、カレンダーに表示される" do
    visit calendar_path
    click_link href: new_stool_record_path(recorded_on: Date.current)

    choose "普通"
    click_button "登録する"

    expect(page).to have_content("記録しました")
    expect(page).to have_content("普通")
  end

  it "同じ日に2件登録しようとすると、エラーが表示される" do
    FactoryBot.create(:stool_record, user: user, recorded_on: Date.current, condition: :normal)

    visit new_stool_record_path(recorded_on: Date.current)
    choose "硬便"
    click_button "登録する"

    expect(page).to have_content("この日の記録はすでにあります")
    expect(user.stool_records.count).to eq 1
  end

  it "記録を消去すると、カレンダーから消える" do
    FactoryBot.create(:stool_record, user: user, recorded_on: Date.current, condition: :normal)

    visit new_stool_record_path(recorded_on: Date.current)
    click_button "この記録を消去する"

    expect(page).to have_content("記録を消去しました")
    expect(page).to have_no_content("普通")
    expect(user.stool_records.count).to eq 0
  end
end
