class CreateThingWidgets < ActiveRecord::Migration
  def change
    create_table :thing_widgets do |t|
      t.integer :gateway_id
      t.text :settings
      t.boolean :enabled
      t.string :timestamp

      t.timestamps
    end
  end
end
