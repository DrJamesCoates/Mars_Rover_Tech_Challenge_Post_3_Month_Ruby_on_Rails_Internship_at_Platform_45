class PlateausController < ApplicationController

  def new
    
  end

  def create
    @plateau = Plateau.new(plateau_params)
    if @plateau.save
      flash[:success] = "Plateau created!"
      redirect_to @plateau
    else
      flash.now[:danger] = @plateau.errors.full_messages[0]
      render 'new'
    end
  end

  def show
    @plateau = Plateau.find_by(id: params[:id])
  end

  def index
    @plateaus = Plateau.paginate(page: params[:page], per_page: 5 )
    @plateaus_count = @plateaus.count
  end

  def edit
    @plateau = Plateau.find_by(id: params[:id])
  end

  def update
    @plateau = Plateau.find_by(id: params[:id])
    if @plateau.update(plateau_params)
      flash[:success] = "Plateau updated!"
      redirect_to @plateau
    else
      @plateau = Plateau.find_by(id: params[:id])
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
