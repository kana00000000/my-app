Rails.application.routes.draw do
  devise_for :users

  # トップページ
  root "tops#index"

  # カレンダー画面（ログインが必要）
  resource :calendar, only: :show

  # 退会の確認画面（ログインが必要）
  resource :withdrawal, only: :show

  # ヘルスチェック（アプリが動いているかを確認するための入口）
  get "up" => "rails/health#show", as: :rails_health_check
end
