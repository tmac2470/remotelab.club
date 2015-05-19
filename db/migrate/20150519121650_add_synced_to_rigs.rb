class AddSyncedToRigs < ActiveRecord::Migration
  def change
    add_column :rigs, :synced, :boolean, default: false
  end
end
