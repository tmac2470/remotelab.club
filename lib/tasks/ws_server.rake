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
            if data['from'] == 'gateway'
              if data['command'] == 'register'
                puts 'Registering gateway'
                ws.send('Registering gateway...')
              elsif data['command'] == 'addThing'
                puts 'adding thing'
                gateway = Gateway.find_by(gateway_hash: data['gateway_hash'])
                if gateway
                  gateway.things.create(thing_addr: data['address'], thing_type: data['value'])
                else
                  puts 'failed to find gateway'
                end
              elsif data['command'] == 'logData'
                gateway = Gateway.find_by(gateway_hash: data['gateway_hash'])
                if gateway
                  gateway.things.find_by(thing_addr: data['address']) do |thing|
                    thing.thing_datas.create(data: data['value'])
                  end
                else
                  puts 'failed to find gateway'
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
