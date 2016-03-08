class GatewaysController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_gateway, only: [:show, :edit, :update, :destroy, :ui_designer, :l_session]

  respond_to :html
  
  
  # List of new gateways (those with synched not set to true yet)
  def new
    @pending_gateways = Gateway.where(synched: false)
    respond_with(@pending_gateways)
  end 
  
  def index
  #TCM - correct this to apply only specific ones to view!
    @gateways = Gateway.find_each
	respond_with(@gateways)
  end
  
  def mqtt_publish

    gateway_hash = params[:gateway_hash]
    thing_address = params[:thing_address]
    command = params[:thing_command]
    message = params[:thing_value]

    topic = "gateways/#{gateway_hash}/things/#{thing_address}/#{command}"

    MQTT::Client.connect('localhost') do |c|
      c.publish(topic, message)
    end

    render :text => 'Done'
  end
  
  
  def create
    @gateway = current_user.gateways.new(gateways_params)
    flash[:notice] = 'Gateway was successfully created.' if @gateway.save
    respond_with(@gateway)
  end
  
  private
    def set_gateway
      @gateway = Gateway.find(params[:id])
    end
  
   
end
