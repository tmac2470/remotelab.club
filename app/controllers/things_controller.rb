class ThingsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_thing, only: [:show, :edit, :update, :destroy, :ui_designer]

  respond_to :html

  def index
    @things = Thing.all
    respond_with(@things)
  end

  def show
    respond_with(@thing)
  end

  def new
    @thing = Thing.new
    respond_with(@thing)
  end

  def edit
  end

  def create
    @thing = Thing.new(thing_params)
    flash[:notice] = 'Thing was successfully created.' if @thing.save
    respond_with(@thing)
  end

  def update
    flash[:notice] = 'Thing was successfully updated.' if @thing.update(thing_params)
    respond_with(@thing)
  end

  def destroy
    @thing.destroy
    respond_with(@thing)
  end

  private
    def set_thing
      @thing = Thing.includes(:thing_logs).find(params[:id])
    end

    def thing_params
      params[:thing].permit(:thing_type, :thing_addr, :thing_hash, :thing_log_ids => [], :laboratory_ids => [])
    end
end
