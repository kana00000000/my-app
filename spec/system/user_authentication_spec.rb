require "rails_helper"

RSpec.describe "ユーザー認証", type: :system do
  include Devise::Test::IntegrationHelpers

  before { driven_by(:rack_test) }

  it "新規登録すると、ログインした状態でカレンダー画面に移動し、ログアウトしても再ログインできる" do
    visit new_user_registration_path

    fill_in "user_name", with: "テストユーザー"
    fill_in "user_email", with: "test@example.com"
    fill_in "user_password", with: "password123"
    fill_in "user_password_confirmation", with: "password123"
    click_button "登録する"

    expect(page).to have_current_path(calendar_path)
    expect(page).to have_content("テストユーザーさん、ログイン中です")

    click_button "ログアウト"

    visit new_user_session_path
    fill_in "user_email", with: "test@example.com"
    fill_in "user_password", with: "password123"
    click_button "ログインする"

    expect(page).to have_current_path(calendar_path)
    expect(page).to have_content("テストユーザーさん、ログイン中です")
  end

  it "ログインしていない状態でカレンダーを開くと、ログイン画面に移動する" do
    visit calendar_path

    expect(page).to have_current_path(new_user_session_path)
  end
end
