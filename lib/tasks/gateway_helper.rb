require 'json'
require 'mqtt'
class GatewayHelper

  def self.execute_command(command, json_data)
    p command
    p json_data
		
    case command
	when "register"
	    register(json_data['gateway_hash'])
	when "status"
		get_status(json_data['gateway_hash'])
    end

  end

  private
  
  def self.register(gateway_hash)
    p gateway_hash
	
	gw = Gateway.create_with(password: gateway_hash, synched: "0", status: "registered").find_or_create_by(gateway_hash: gateway_hash)
	gw.save

	topic = "gateways/status"
	# TCM UPDATE TO CORRECT VALUE - Synched for now but can change
	#message = gw.status 
	message = '{"gateway_hash": "' + gw.gateway_hash + '", "status": "' + gw.status + '"}'	
	
    MQTT::Client.connect('localhost') do |c|
      c.publish(topic, message)
    end

	rescue ActiveRecord::RecordNotUnique
		retry	
	
  end

  def self.get_status(gateway_hash)
	# Does not do anything at this stage - just prints out status
	status = Gateway.select("id", "status").where(gateway_hash: gateway_hash)
	p status
  end
	
  def self.health_update(gateway_hash)
    p gateway_hash
  end
end
