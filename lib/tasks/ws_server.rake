require 'em-websocket'
require 'json'
begin
  namespace :ws_server do
    task :start => :environment do
      EM.run {
        EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|
          ws.onopen { |handshake|
            puts "WebSocket connection open"

            # Access properties on the EM::WebSocket::Handshake object, e.g.
            # path, query_string, origin, headers

            # Publish message to the client
            ws.send "Connected to remotelab.club websocket"
          }

          ws.onclose { puts "Connection closed" }

          ws.onmessage { |msg|
            puts "Recieved message: #{msg}"

            data = JSON.parse(msg)

            # from master (yun)
            if data['from'] == 'rig'
              if data['command'] == 'register'
                puts 'Registering rig'
                ws.send('Registering rig...')
              elsif data['command'] == 'addSlave'
                puts 'adding slave'
                rig = Rig.find_by(rig_hash: data['rig_hash'])
                if rig
                  rig.slave_modules.create(s_addr: data['address'], s_type: data['value'])
                else
                  puts 'failed to find rig'
                end
              elsif data['command'] == 'logData'
                rig = Rig.find_by(rig_hash: data['rig_hash'])
                if rig
                  rig.slave_modules.find_by(s_addr: data['address']) do |slave|
                    slave.slave_datas.create(data: data['value'])
                  end
                else
                  puts 'failed to find rig'
                end
              end
            end

            # from web browser
            if data['from'] == 'client'
              ws.send("#{User.first.email}\t")
            end

          }
        end
      }
    end
  end
end
