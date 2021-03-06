class PinsController < ApplicationController
  before_action :find_pin, only: %i[show edit update destroy upvote]
  before_action :authenticate_user!, except: %i[index show]
  def index
    @pins = Pin.all.order('created_at desc')
  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build(pin_params)

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

  def upvote
    @pin.upvote_by current_user
    redirect_back fallback_location: @post
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description, :image)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
