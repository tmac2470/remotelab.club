require 'json'
class SlaveHelper

  def self.execute_command(rig_hash, json_data)
    p rig_hash
    p json_data

    rig = Rig.find_by(rig_hash: rig_hash)

    if rig
      case json_data['command'].to_i
      when 0 # register slave
        register(rig, json_data['address'].to_i, json_data['value'].to_i)
      when 1 # deregister slave
        remove(rig, json_data['address'].to_i)
      when 2 # log data
        log_data(rig, json_data['address'].to_i, json_data['value'])
      else
        p 'Invalid command.'
      end
    end
  end

  private

  def self.register(rig, slave_address, slave_type)
    p 'register', rig, slave_address, slave_type

    rig.slave_modules.create(s_addr: slave_address, s_type: slave_type)
  end

  def self.remove(rig, slave_address)
    p 'remove', rig, slave_address
  end

  def self.log_data(rig, slave_address, args)
    p 'log_data', rig, slave_address, args
    slave = rig.slave_modules.find_by(s_addr: slave_address.to_i)
    slave.slave_datas.create(data: args)
  end

end
