class CreateSlaveData < ActiveRecord::Migration
  def change
    create_table :slave_data do |t|
      t.integer :slave_module_id
      t.text :data

      t.timestamps
    end
  end
end
