require 'json'
class SlaveHelper

  def self.execute_command(rig_hash, slave_address, command, args)
    p rig_hash
    p slave_address
    p command
    p args

    rig = Rig.first

    if command == 'register'
      register(rig, slave_address, args.to_i)
    elsif command == 'remove'
      remove(rig, slave_address)
    elsif command == 'logData'
      log_data(rig, slave_address, args)
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
