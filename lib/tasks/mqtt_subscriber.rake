require 'mqtt'
require 'json'
import 'lib/tasks/thing_helper.rb'
import 'lib/tasks/gateway_helper.rb'

begin
  namespace :mqtt_subscriber do
    task :start => :environment do
      MQTT::Client.connect('localhost') do |c|
        # If you pass a block to the get method, then it will loop
        c.get('#') do |topic,message|
          puts "#{topic}: #{message}"

          begin
            # split the topic into array
            topic_path = topic.split('/')

			# structure is identifier/command with payload including gateway_hash
            ident = topic_path[0]
			command = topic_path[1]
			
            # parse the json dump
            data = JSON.parse(message)
			p ident
			p command
			
            case ident
				when "gateways"
					GatewayHelper.execute_command(command, data)
				when "things"
					ThingHelper.execute_command(command, topic_path, data)
			end
			
          rescue Exception => e
            puts e.message

          # ensure
            p 'shit just broke dude'

          end
		end
      end
    end
  end
end
