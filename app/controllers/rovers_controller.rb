class RoversController < ApplicationController

  def new
  end

  def create
    @plateau = Plateau.find_by(id: params[:plateau_id])
    @rover = @plateau.rovers.build(rover_create_params)
    if @rover.save
      flash[:success] = "Rover created!"
      redirect_to @plateau
    else
      flash.now[:danger] = @rover.errors.full_messages[0]
      render 'new'
    end
  end

  def edit
    @rover = Rover.find_by(id: params[:id])
  end

  def update
    @rover = Rover.find_by(id: params[:id])
    if @rover.update(rover_update_params)
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

  def move
    @rover = Rover.find_by(id: params[:id])
    @plateau = Plateau.find_by(id: @rover.plateau_id)
  end

  def update_position
    @movement_instructions_array = process_movement_instructions(params[:movement_instruction])
    @rover = Rover.find_by(id: params[:id])
    @plateau = Plateau.find_by(id: @rover.plateau_id)
    unless check_movement_instructions(@movement_instructions_array)
      flash[:danger] = "Incorrect movement instructions!"
      render 'move'
      return
    end
    updated_position = adjust_heading_and_position(@rover.x_coordinate, @rover.y_coordinate, @rover.heading, @movement_instructions_array)
    if @rover.update(updated_position)
      flash[:success] = "Rover moved successfully!"
      redirect_to plateau_url(@rover.plateau_id)
    else
      flash[:danger] = @rover.errors.full_messages[0]
      render 'move'
    end
  end

  private
  def rover_create_params
    x_coordinate = rand(0..@plateau.top_right_x_coordinate)
    y_coordinate = rand(0..@plateau.top_right_y_coordinate)
    heading = ["N", "E", "S", "W"].sample
    { name: params[:name], x_coordinate: x_coordinate, y_coordinate: y_coordinate, heading: heading }
  end

  def rover_update_params
    params.permit(:name)
  end

  def process_movement_instructions(movement_instructions)
    movement_instructions.strip.upcase.split("").to_a
  end

  def check_movement_instructions(movement_instructions_array)
    movement_instructions_array.each { |character| return false unless ["L", "M", "R"].include?(character) }
    return true
  end

  def adjust_heading_and_position(x_coordinate, y_coordinate, heading, processed_and_checked_movement_instructions_array)
    adjust_x_coordinate_position_hash = { E: 1, W: -1 }
    adjust_y_coordinate_position_hash = { N: 1, S: -1 }
    hash_for_heading_array = { L: ["N", "W", "S", "E", "N"], R: ["N", "E", "S", "W", "N"] }

    processed_and_checked_movement_instructions_array.each do |instruction|
      if instruction == "M"
        symbolized_heading = heading.to_sym
        x_coordinate += adjust_x_coordinate_position_hash[symbolized_heading] || 0
        y_coordinate += adjust_y_coordinate_position_hash[symbolized_heading] || 0
      else
        heading_array = hash_for_heading_array[instruction.to_sym]
        new_heading_index = heading_array.index(heading) + 1
        heading = heading_array[new_heading_index]
      end
    end
    { heading: heading, x_coordinate: x_coordinate, y_coordinate: y_coordinate }
  end

end