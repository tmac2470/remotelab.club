class AddPinToSlaveDatas < ActiveRecord::Migration
  def change
    add_column :slave_data, :pin, :integer
  end
end
