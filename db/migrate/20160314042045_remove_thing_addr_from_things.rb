class RemoveThingAddrFromThings < ActiveRecord::Migration
  def change
    remove_column :things, :thing_addr, :integer
  end
end
