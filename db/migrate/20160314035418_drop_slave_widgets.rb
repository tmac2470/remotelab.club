class DropSlaveWidgets < ActiveRecord::Migration
  def change
  	drop_table :slave_widgets
end
end
