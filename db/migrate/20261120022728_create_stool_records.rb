class CreateStoolRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :stool_records do |t|
      t.references :user, null: false, foreign_key: true
      t.date :recorded_on, null: false
      t.integer :condition, null: false

      t.timestamps
    end

    # 同じユーザーが、同じ日の記録を2件持てないようにする
    add_index :stool_records, [ :user_id, :recorded_on ], unique: true
  end
end
