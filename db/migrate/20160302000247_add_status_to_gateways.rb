class AddStatusToGateways < ActiveRecord::Migration
  def change
    add_column :gateways, :status, :string
  end
end
