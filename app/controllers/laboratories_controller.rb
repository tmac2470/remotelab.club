require 'mqtt'
class LaboratoriesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_laboratory, only: [:show, :edit, :update, :destroy, :ui_designer, :l_session, :published]
  before_action :defined_widgets, only: [:ui_designer, :l_session]

  respond_to :html

  def index
    @laboratories = current_user.laboratories
    respond_with(@laboratories)
  end
  
  # ??? Not yet sure how this works?
  def show
    @thing_logs = @laboratory.thing_logs.includes(:thing) 
	@things = @laboratory.things
    respond_with(@thing_logs, @things)
  end
  
  def new
    @available_things = Thing.where(status: "registered")
    @laboratory = Laboratory.new
    respond_with(@laboratory, @available_things)
  end 

  def edit
  end
  
  def ui_designer
    
	# remove dead things
    #@laboratory.things.each do |thing|
    #  if thing.thing_logs.last == nil
    #    thing.delete
    #  elsif thing.thing_logs.last.created_at < 15.seconds.ago
    #    thing.delete
    #  end
    #end
	
    #@things = @laboratory.things
    #@switchable_things = @laboratory.things.where(thing_type: 0)
	#@servo_things = @laboratory.things.where(thing_type: 2)
	#@motor_things = @laboratory.things.where(thing_type: 3)
    
	@chartable_things = @laboratory.things.where.not(thing_type: 0).includes(:thing_logs)
	@chartable_logs = @laboratory.thing_logs.includes(:thing).where("thing_type != ?",0)
  end
  
  
  def l_session
    redirect_to experiments_path, alert: 'This experiment is not available at the moment, please try again later...' if @laboratory.things.count == 0
    @ui_json = JSON.parse(@laboratory.ui_json)
  end
  
  def get_chart_data
    @thing = Thing.find(params[:thing_id])
	@thing_log = params[:thing_log_id]

    @time = Time.at(params[:from].to_i / 1000.0)

    @data = @thing.thing_logs.where('id = ? AND updated_at > ?', @thing_log, @time).pluck(:data)

    #@data.each do |val|
	#	puts val
	#	ret_val.push({x: val[1].to_f * 1000, y: val[0].to_f})
    #end

	puts @data
    #render :json => ret_val
	render :json => @data
  end

  def get_log_data
    @thing = Thing.find(params[:thing_id])
    @pin = params[:pin]

    @time = Time.at(params[:from].to_i / 1000.0)

    @data = @thing.thing_logs.where('pin = ? AND created_at > ?', @pin, @time).pluck(:data, :created_at).last

    ret_val = nil

    ret_val = {time: @data[1].strftime('%H:%M:%S'), value: @data[0]} unless @data.nil?

    render :json => ret_val
  end
  
  
  def create
    @laboratory = current_user.laboratories.new(laboratory_params)
    flash[:notice] = 'Laboratory was successfully created.' if @laboratory.save
    respond_with(@laboratory)
  end
  
  def update
    flash[:notice] = 'Laboratory was successfully updated.' if @laboratory.update(laboratory_params)
    respond_with(@laboratory)
  end
  
  def destroy
    @laboratory.destroy
    respond_with(@laboratory)
  end
  
  def experiments
    @experiments = Laboratory.where(published: true)
  end  
  
  def published
	@laboratory = Laboratory.find(params[:id])
    flash[:notice] = 'Laboratory was successfully published.' if @laboratory.update(:published => params[:published])
    respond_with(@laboratory)
  end
	
  private
    def set_laboratory
      @laboratory = Laboratory.includes(:thing_logs).find(params[:id])
    end
	
	def laboratory_params
      params.require(:laboratory).permit(:title, :laboratory_type, :description, :pdf_file, :ui_json, :password, :published, :thing_ids => [])
    end
	
	def defined_widgets
      @defined_widgets = {
        "line-chart"=> {title: 'Line chart', image: '/widgets/line-chart.png', form: 'chart-form'},
        #"bar-chart"=> {title: 'Bar chart', image: '/widgets/bar-chart.png', #form: 'chart-form'},
        #"switch"=> {title: 'Switch', image: '/widgets/switch.png', form: #'switch-form'},
        #"data-log"=> {title: 'Data Log', image: '/widgets/data-log.png', form: #'data-log-form'},
        #"value"=> {title: 'Value', image: '/widgets/value.png', form: #'value-form'},
        #"motor"=> {title: 'Motor', image: '/widgets/motor.png', form: #'motor-form'},
        #"servo"=> {title: 'Servo', image: '/widgets/servo.png', form: #'servo-form'}
      }
    end

	
end
