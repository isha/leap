class GesturesController < ApplicationController
  def index
    @gestures = Gesture.all
  end

  def new
    @gesture = Gesture.new
  end

  def create
    @gesture = Gesture.new(gesture_params)

    if @gesture.save
      redirect_to @gesture
    else
      render :new
    end
  end

  def show
    @gesture = Gesture.find(params[:id])
  end

  def destroy
    @gesture = Gesture.find(params[:id])
    @gesture.destroy

    redirect_to gestures_path
  end

  private
  def gesture_params
    params.require(:gesture).permit(:title, :compressed_data)
  end
end
