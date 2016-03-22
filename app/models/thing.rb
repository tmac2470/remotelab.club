class Thing < ActiveRecord::Base
  has_and_belongs_to_many :laboratories
  belongs_to :gateway
  has_many :thing_logs
  accepts_nested_attributes_for :thing_logs

  enum thing_type: [:switch, :analog_reader, :temperature_sensor, :motor, :servo, :sensorTag]
 end
