class DropThingData < ActiveRecord::Migration
  def change
    	drop_table :thing_data
	end
end
