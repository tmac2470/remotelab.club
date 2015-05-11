class CreateSlaveModules < ActiveRecord::Migration
  def change
    create_table :slave_modules do |t|
      t.integer :rig_id
      t.integer :s_type
      t.integer :s_addr

      t.timestamps
    end
  end
end
