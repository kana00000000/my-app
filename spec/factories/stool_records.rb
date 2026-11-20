FactoryBot.define do
  factory :stool_record do
    user
    sequence(:recorded_on) { |n| Date.new(2026, 1, 1) + n }
    condition { :normal }
  end
end
