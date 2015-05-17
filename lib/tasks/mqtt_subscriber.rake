require 'mqtt'
require 'json'
import 'lib/tasks/slave_helper.rb'
import 'lib/tasks/rig_helper.rb'

begin
  namespace :mqtt_subscriber do
    task :start => :environment do
      MQTT::Client.connect('localhost') do |c|
        # If you pass a block to the get method, then it will loop
        c.get('rails/#') do |topic,message|
          puts "#{topic}: #{message}"

          begin
            # split the topic into array
            topic_path = topic.split('/')

            # determine the rig hash
            rig_hash = topic_path[1]

            # parse the json dump

            data = JSON.parse(message)

            SlaveHelper.execute_command(rig_hash, data)

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
