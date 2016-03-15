class DropSlaveModule < ActiveRecord::Migration
  def change
 	drop_table :slave_modules
 end
end
