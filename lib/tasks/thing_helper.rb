require 'json'
class ThingHelper
### NOT UPDATED SENSIBLY

  def self.execute_command(command, topic_path, json_data)
    p command
    p json_data
		
    case command
	when "register"
	    register(json_data['thing_hash'],json_data['gateway_hash'], json_data['name'] )
	when "status"
		get_status(json_data['thing_hash'])
	when "log" 
		# Send thing_hash, topic and the data
		log_data(topic_path[2], topic_path[3],json_data)
    end

  end

  private

  def self.register(thing_hash, gateway_hash, name)
    p thing_hash
    p gateway_hash
	
	# Hardcoded thing type - this must change
	gw = Gateway.find_by(gateway_hash: gateway_hash)
	thing = gw.things.create_with(password: thing_hash, status: "registered", thing_type: "1", thing_name: name).find_or_create_by(thing_hash: thing_hash)
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

  def self.log_data(thing_hash, topic, args)
	thing = Thing.find_by(thing_hash: thing_hash)
    thing_log = thing.thing_logs.find_or_create_by(topic: topic)
	p thing_log.id
	
	thing_log.update(data: args)
	thing_log.touch
	thing_log.save
	
    # thing.temperature_sensor?
    #  args.split(',').each_with_index do |p_data, pin|
    #    thing.thing_logs.create(data: p_data, pin: pin)
    #  end
    #else
    #  slave.slave_datas.create(data: args)
    #end

  end
end
