class CreateThingData < ActiveRecord::Migration
  def change
    create_table :thing_data do |t|
      t.integer :thing_id
      t.text :data
      t.string :timestamp

      t.timestamps
    end
  end
end
