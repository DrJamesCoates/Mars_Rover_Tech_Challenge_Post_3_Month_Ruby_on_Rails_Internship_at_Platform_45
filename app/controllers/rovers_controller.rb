class RoversController < ApplicationController

  def new
  end

  def create
    @plateau = Plateau.find_by(id: params[:plateau_id])
    @rover = @plateau.rovers.build(final_params(rover_params[:name]))
    if @rover.save
      flash[:success] = "Rover created!"
      redirect_to @plateau
    else
      flash.now[:danger] = "Could not create rover"
      render 'new'
    end
  end

  def edit
    @rover = Rover.find_by(id: params[:id])
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

  #def move_rover
  #end

  private
  def rover_params
    params.permit(:name)
  end

  def final_params(rover_name)
    x_coordinate = (0..@plateau.top_right_x_coordinate).to_a.sample
    y_coordinate = (0..@plateau.top_right_y_coordinate).to_a.sample
    heading = ["N", "E", "S", "W"].sample
    { name: rover_name, x_coordinate: x_coordinate, y_coordinate: y_coordinate, heading: heading }
  end

  #def process_movement_instructions(movement_instructions)
    #movement_instructions_array = movement_instructions.strip.upcase.split("")
  #end

  #def check_movement_instructions(movement_instructions_array)
    #appropriate_movement_instructions_array = %w(L M R)
    #movement_instructions_array.each do |character|
      #return false unless appropriate_movement_instructions_array.include?(character)
    #end
    #return true
  #end

  #def adjust_heading_and_position(heading, x_coordinate, y_coordinate, processed_and_checked_movement_instructions_array)
    #heading_array = ["N", "E", "S", "W", "N"]
    #adjust_x_position_hash = { E: 1, W: -1 }
    #adjust_y_position_hash = { N: 1, S: -1 }

    #processed_and_checked_movement_instructions_array.each do |instruction|
      #heading_array = heading_array.reverse if instruction == "L" && heading_array == ["N", "E", "S", "W", "N"]
      #if instruction == "M"
        #x_coordinate += adjust_x_position_hash[:heading]
        #y_coordinate += adjust_y_position_hash[:heading]
      #else
        #new_heading_index = heading_array.index(heading) + 1
        #heading = heading_array[new_heading_index]
      #end
    #end
  #end
  
  


end