class DropRigs < ActiveRecord::Migration
  def change
	drop_table :rigs
  end
end
