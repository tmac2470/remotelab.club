class AddStatusAndThingHashToThings < ActiveRecord::Migration
  def change
    add_column :things, :status, :string
    add_column :things, :thing_hash, :string
  end
end
