class CreateSlaveWidgets < ActiveRecord::Migration
  def change
    create_table :slave_widgets do |t|
      t.integer :rig_id
      t.text :settings
      t.boolean :enabled

      t.timestamps
    end
  end
end
