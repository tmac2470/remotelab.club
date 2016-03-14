class CreateThingLogs < ActiveRecord::Migration
  def change
    create_table :thing_logs do |t|
      t.integer :thing_id
      t.json :data
      t.string :topic
      t.string :timestamp

      t.timestamps
    end
  end
end
