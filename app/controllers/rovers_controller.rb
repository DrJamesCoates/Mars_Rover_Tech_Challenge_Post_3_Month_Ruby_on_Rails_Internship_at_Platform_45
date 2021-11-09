class RoversController < ApplicationController

  def new
  end

  def create
    @plateau = Plateau.find_by(id: params[:plateau_id])
    @rover = @plateau.rovers.build(rover_params)
    if @rover.save
      flash[:success] = "Rover created!"
      redirect_to @plateau
    else
      flash.now[:danger] = "Could not create rover"
      render 'new'
    end
  end

  def edit
  end

  def update
    @rover = Rover.find_by(id: params[:id])
    if @rover.update(rover_params)
      flash[:success] = "Rover updated!"
      redirect_to plateau_url(params[:plateau_id])
    else
      flash.now[:danger] = "Could not update rover"
      render 'edit'
    end
  end

  def destroy
    @rover = Rover.find_by(id: params[:id])
    @rover.destroy
    flash[:success] = "Rover destroyed!"
    redirect_to plateau_url(params[:plateau_id])
  end

  private
  def rover_params
    params.permit(:name, :x_coordinate, :y_coordinate, :heading, :plateau_id)
  end

end