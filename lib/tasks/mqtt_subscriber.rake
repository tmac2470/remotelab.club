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

            if topic_path[2] == 'slaves'
              # slave is talking to the server here

              slave_address = topic_path[3]
              slave_command = topic_path[4]
              slave_args = message

              # call the slave helper to execute it - keeping shit clean here
              SlaveHelper.execute_command(rig_hash, slave_address, slave_command, slave_args)

            elsif topic_path[2] == 'register'
              # register the rig -> create a new rig via the rig helper
              RigHelper.register(rig_hash)
            elsif topic_path[2] == 'healthUpdate'
              # call the health update
              RigHelper.health_update(rig_hash)
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
