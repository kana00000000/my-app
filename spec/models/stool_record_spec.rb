require "rails_helper"

RSpec.describe StoolRecord, type: :model do
  describe ".in_calendar_month" do
    let(:user) { FactoryBot.create(:user) }

    it "その月と、カレンダーに表示される前後の週の記録だけを返す" do
      inside = [ Date.new(2026, 10, 26), Date.new(2026, 11, 15), Date.new(2026, 12, 6) ].map do |date|
        FactoryBot.create(:stool_record, user: user, recorded_on: date)
      end
      FactoryBot.create(:stool_record, user: user, recorded_on: Date.new(2026, 10, 25))
      FactoryBot.create(:stool_record, user: user, recorded_on: Date.new(2026, 12, 7))

      expect(StoolRecord.in_calendar_month(Date.new(2026, 11, 15))).to match_array(inside)
    end
  end
end
