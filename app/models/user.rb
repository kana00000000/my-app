class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :stool_records, dependent: :destroy

  validates :name, presence: true

  # 指定した日の記録を返す（なければ nil）
  def stool_record_on(date)
    return if date.blank?

    stool_records.find_by(recorded_on: date)
  end
end
