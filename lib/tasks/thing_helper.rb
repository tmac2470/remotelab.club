require 'json'
class ThingHelper
### NOT UPDATED SENSIBLY

  def self.execute_command(command, json_data)
    p command
    p json_data
		
    case command
	when "register"
	    register(json_data['thing_hash'],json_data['gateway_hash'] )
	when "status"
		get_status(json_data['thing_hash'])
    end

  end

  private

  def self.register(thing_hash, gateway_hash)
    p thing_hash
    p gateway_hash
	
	gw = Gateway.find_by(gateway_hash: gateway_hash)
	thing = gw.things.create_with(password: thing_hash, status: "registered").find_or_create_by(thing_hash: thing_hash)
	thing.save

	topic = "things/status"
	#message = gw.status 
	message = '{"thing_hash": "' + thing.thing_hash + '", "status": "' + thing.status + '"}'	
	
    MQTT::Client.connect('localhost') do |c|
      c.publish(topic, message)
    end

	rescue ActiveRecord::RecordNotUnique
		retry	
	
  end

  def self.get_status(thing_hash)
	# Does not do anything at this stage - just prints out status
	status = Thing.select("id", "status").where(thing_hash: thing_hash)
	p status
  end
	
  def self.health_update(thing_hash)
    p thing_hash
  end

end
