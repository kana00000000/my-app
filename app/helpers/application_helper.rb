module ApplicationHelper
  # ログイン中だけ、アプリ名の後ろに🌱を付ける
  def app_name
    user_signed_in? ? "おなかカレンダー🌱" : "おなかカレンダー"
  end
end
