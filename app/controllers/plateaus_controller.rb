class PlateausController < ApplicationController

  def new
    
  end

  def create
    @plateau = Plateau.new(plateau_params)
    if @plateau.save
      flash[:success] = "Plateau created!"
      redirect_to @plateau
    else
      flash.now[:danger] = "Could not create plateau"
      render 'new'
    end
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
    @plateau = Plateau.find_by(id: params[:id])
    if @plateau.update(plateau_params)
      flash[:success] = "Plateau updated!"
      redirect_to @plateau
    else
      flash.now[:danger] = "Could not update plateau"
      render 'edit'
    end
  end

  def destroy
    @plateau = Plateau.find_by(id: params[:id])
    @plateau.destroy
    flash[:success] = "Plateau deleted!"
    redirect_to plateaus_url
  end

  private
    def plateau_params
      params.permit(:name, :top_right_x_coordinate, :top_right_y_coordinate, :explored)
    end
end
