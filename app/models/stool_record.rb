class StoolRecord < ApplicationRecord
  # 画面に表示する、便の状態の名前
  CONDITION_LABELS = {
    "normal" => "普通",
    "hard" => "硬便",
    "soft" => "軟便",
    "diarrhea" => "下痢"
  }.freeze

  belongs_to :user

  # 便の状態（数字で保存して、名前で扱う）
  enum :condition, { normal: 0, hard: 1, soft: 2, diarrhea: 3 },
       validate: { allow_nil: true, message: "便の状態を選んでください" }

  validates :recorded_on, presence: { message: "日付を選んでください" }
  validates :condition, presence: { message: "便の状態を選んでください" }
  validates :recorded_on, uniqueness: { scope: :user_id, message: "この日の記録はすでにあります" }

  # カレンダーに表示する期間（その月と、前後の週のはみ出し分）の記録
  scope :in_calendar_month, ->(date) {
    where(recorded_on: date.beginning_of_month.beginning_of_week..date.end_of_month.end_of_week)
  }

  def condition_label
    CONDITION_LABELS[condition]
  end
end
