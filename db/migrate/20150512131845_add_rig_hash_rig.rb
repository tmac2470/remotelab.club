class AddRigHashRig < ActiveRecord::Migration
  def change
    add_column :rigs, :rig_hash, :string
  end
end
