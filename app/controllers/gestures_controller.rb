class GesturesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @gestures = Gesture.search(params[:search]).order(sort_column + " " + sort_direction)
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

  def test
    data = Gesture.find(params[:id]).compressed_data
    respond_to do |format|
      format.json { render :json => data }
    end
  end

  private
  def gesture_params
    params.require(:gesture).permit(:title, :compressed_data)
  end

  def sort_column
    Gesture.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
