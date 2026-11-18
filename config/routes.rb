Rails.application.routes.draw do
  # トップページ
  root "tops#index"

  # ヘルスチェック（アプリが動いているかを確認するための入口）
  get "up" => "rails/health#show", as: :rails_health_check
end
