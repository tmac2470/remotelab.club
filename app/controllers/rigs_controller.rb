require 'mqtt'
class RigsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_rig, only: [:show, :edit, :update, :destroy, :ui_designer, :r_session]
  before_action :defined_widgets, only: [:ui_designer, :r_session]

  respond_to :html

  def index
    @rigs = current_user.rigs
    respond_with(@rigs)
  end

  def show

    # remove dead slaves
    @rig.slave_modules.each do |slave|
      if slave.slave_datas.last == nil
        slave.delete
      elsif slave.slave_datas.last.created_at < 15.seconds.ago
        slave.delete
      end
    end

    @slave = @rig.slave_modules
    respond_with(@rig)
  end

  def new
    @pending_rigs = Rig.where(synced: false)
    respond_with(@pending_rigs)
  end

  def edit
  end

  def ui_designer

    # remove dead slaves
    @rig.slave_modules.each do |slave|
      if slave.slave_datas.last == nil
        slave.delete
      elsif slave.slave_datas.last.created_at < 20.seconds.ago
        slave.delete
      end
    end

    @slave_modules = @rig.slave_modules
    @switchable_slaves = @rig.slave_modules.where(s_type: 0)
    @chartable_slaves = @rig.slave_modules.where.not(s_type: 0)
    @motor_slaves = @rig.slave_modules.where.not(s_type: 3)
  end

  def r_session
    redirect_to experiments_path, alert: 'This experiment is not available at the moment, please try again later...' if @rig.slave_modules.count == 0
    @ui_json = JSON.parse(@rig.ui_json)
  end

  def mqtt_publish

    rig_hash = params[:rig_hash]
    slave_address = params[:s_address]
    command = params[:s_command]
    message = params[:s_value]

    topic = "rigs/#{rig_hash}/slaves/#{slave_address}/#{command}"

    MQTT::Client.connect('localhost') do |c|
      c.publish(topic, message)
    end

    render :text => 'Done'
  end

  def get_chart_data
    @slave = SlaveModule.find(params[:slave_id])
    @pin = params[:pin]

    @time = Time.at(params[:from].to_i / 1000.0)

    @data = @slave.slave_datas.where('pin = ? AND created_at > ?', @pin, @time).pluck(:data, :created_at)

    ret_val = []

    @data.each do |val|
      ret_val.push({x: val[1].to_f * 1000, y: val[0].to_f})
    end

    render :json => ret_val
  end

  def get_log_data
    @slave = SlaveModule.find(params[:slave_id])
    @pin = params[:pin]

    @time = Time.at(params[:from].to_i / 1000.0)

    @data = @slave.slave_datas.where('pin = ? AND created_at > ?', @pin, @time).pluck(:data, :created_at).last

    ret_val = nil

    ret_val = {time: @data[1].strftime('%H:%M:%S'), value: @data[0]} unless @data.nil?

    render :json => ret_val
  end

  def create
    @rig = current_user.rigs.new(rig_params)
    flash[:notice] = 'Rig was successfully created.' if @rig.save
    respond_with(@rig)
  end

  def update
    flash[:notice] = 'Rig was successfully updated.' if @rig.update(rig_params)
    respond_with(@rig)
  end

  def destroy
    @rig.destroy
    respond_with(@rig)
  end


  def experiments
    @experiments = Rig.where(published: true)
  end

  private
    def set_rig
      @rig = Rig.find(params[:id])
    end

    def rig_params
      params.require(:rig).permit(:title, :rig_type, :description, :pdf_file, :ui_json, :password)
    end

    def defined_widgets
      @defined_widgets = {
        "line-chart"=> {title: 'Line chart', image: '/widgets/line-chart.png', form: 'chart-form'},
        "bar-chart"=> {title: 'Bar chart', image: '/widgets/bar-chart.png', form: 'chart-form'},
        "switch"=> {title: 'Switch', image: '/widgets/switch.png', form: 'switch-form'},
        "data-log"=> {title: 'Data Log', image: '/widgets/data-log.png', form: 'data-log-form'},
        "value"=> {title: 'Value', image: '/widgets/value.png', form: 'value-form'},
        "motor"=> {title: 'Motor', image: '/widgets/motor.png', form: 'motor-form'}
      }
    end
end
