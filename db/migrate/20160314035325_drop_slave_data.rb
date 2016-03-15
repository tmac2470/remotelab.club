class DropSlaveData < ActiveRecord::Migration
  def change
  	drop_table :slave_data
  end
end
