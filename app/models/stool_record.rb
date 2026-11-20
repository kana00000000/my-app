class StoolRecord < ApplicationRecord
  belongs_to :user

  # 便の状態（数字で保存して、名前で扱う）
  enum :condition, { normal: 0, hard: 1, soft: 2, diarrhea: 3 }

  validates :recorded_on, presence: true
  validates :condition, presence: true
  validates :recorded_on, uniqueness: { scope: :user_id }
end
