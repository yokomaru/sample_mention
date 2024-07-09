class CreateMentions < ActiveRecord::Migration[7.1]
  def change
    create_table :mentions do |t|
      t.references :report, foreign_key: true
      t.references :mentioned_report, foreign_key: { to_table: :reports }

      t.timestamps
    end
    add_index :mentions, [:report_id, :mentioned_report_id], unique: true
  end
end
