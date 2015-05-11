class RigsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_rig, only: [:show, :edit, :update, :destroy, :ui_designer]

  respond_to :html

  def index
    @rigs = current_user.rigs
    respond_with(@rigs)
  end

  def show
    respond_with(@rig)
  end

  def new
    @rig = Rig.new
    respond_with(@rig)
  end

  def edit
  end

  def ui_designer
    @slave_modules = @rig.slave_modules

    @defined_widgets = {
      "line-chart"=> {title: 'Line chart', image: '/widgets/line-chart.png', form: 'chart-form'},
      "bar-chart"=> {title: 'Bar chart', image: '/widgets/bar-chart.png', form: 'chart-form'},
      "switch"=> {title: 'Switch', image: '/widgets/switch.png', form: 'switch-form'}
    }

    @switchable_slaves = @rig.slave_modules.where(s_type: 0)
    @chartable_slaves = @rig.slave_modules.where.not(s_type: 0)
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

  private
    def set_rig
      @rig = Rig.find(params[:id])
    end

    def rig_params
      params.require(:rig).permit(:title, :rig_type, :description, :pdf_file, :ui_json)
    end
end
