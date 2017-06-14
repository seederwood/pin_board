class PinsController < ApplicationController
  before_action :find_pin, only: %i[show edit update destroy]
  def index
    @pins = Pin.all.order('created_at desc')
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)

    if @pin.save
      redirect_to @pin, notice: "Pin #{@pin.title} created successfully"
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: "Pin #{@pin.title} updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @pin.destroy

    redirect_to pins_path, notice: "Pin #{@pin.title} deleted successfully"
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
