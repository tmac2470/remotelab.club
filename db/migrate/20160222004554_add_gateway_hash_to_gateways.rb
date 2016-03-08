class AddGatewayHashToGateways < ActiveRecord::Migration
  def change
    add_column :gateways, :gateway_hash, :string
  end
end
