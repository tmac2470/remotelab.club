class Thing < ActiveRecord::Base
  belongs_to :laboratories
  belongs_to :gateway
  has_many :thing_logs
  accepts_nested_attributes_for :thing_logs

  enum s_type: [:switch, :analog_reader, :temperature_sensor, :motor, :servo, :sensorTag]
 end
