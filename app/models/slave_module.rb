class SlaveModule < ActiveRecord::Base
  belongs_to :rig
  has_many :slave_datas

  enum s_type: [:switch, :temperature_sensor, :servo]
end
