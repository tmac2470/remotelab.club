class AddGatewayNameAndDescriptionToGateways < ActiveRecord::Migration
  def change
    add_column :gateways, :gateway_name, :string
    add_column :gateways, :description, :string
  end
end
