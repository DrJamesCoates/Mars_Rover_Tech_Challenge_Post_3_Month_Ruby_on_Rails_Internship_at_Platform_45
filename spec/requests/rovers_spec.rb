require 'rails_helper'

RSpec.describe "Rovers", type: :request do
  
  let!(:plateau) { create(:plateau) }
  let!(:rover) { create(:rover) }

  let(:valid_attributes) do
    { name: "Valid name" }
  end
  let(:invalid_attributes) do
    { name: "" }
  end
  let(:valid_update_attributes) do
    { name: "Valid update name" }
  end

  describe "POST /plateaus/:id/rovers" do
    context "with valid attributes" do
      it "flashes a success message, increments the rovers count by 1 and redirects to the plateau show view" do
        old_rover_count = Rover.count
        post "/plateaus/#{plateau.id}/rovers", params: valid_attributes
        expect(Rover.count).to eq(old_rover_count + 1)
        expect(flash[:success]).to eq("Rover created!")
        expect(response).to redirect_to(plateau)
      end
    end

    context "with invalid attributes" do
      it "flashes an error message and does not create a rover" do
        old_rover_count = Rover.count
        post "/plateaus/#{plateau.id}/rovers", params: invalid_attributes
        expect(flash[:danger]).to eq("Name can't be blank")
        expect(Rover.count).to eq(old_rover_count)
      end
    end
  end

  describe "PATCH /plateaus/:id/rovers/:id" do
    
    context "with valid update attributes" do
      it "updates the rover, flashes a success message and redirects to the plateau show view" do
        patch "/plateaus/1/rovers/#{rover.id}", params: valid_update_attributes
        rover.reload

        expect(rover.name).to eq(valid_update_attributes[:name])
        expect(flash[:success]).to eq("Rover updated!")
        expect(response).to redirect_to(plateau)
      end
    end

    context "with invalid_update_attributes" do
      it "flashes an error messsage and does not update the rover attribrutes" do
        old_rover_name = rover.name
        patch "/plateaus/1/rovers/#{rover.id}", params: invalid_attributes

        expect(flash[:danger]).to eq("Could not update rover")
        rover.reload
        expect(rover.name).to eq(old_rover_name)
      end
    end
  end

  describe "DELETE /plateaus/:id/rovers/:id" do
    it "reduces the rover count by 1, renders a success message and redirects to the plateau show view" do
      old_rover_count = Rover.count
      delete "/plateaus/1/rovers/#{rover.id}"
      expect(Rover.count).to eq(old_rover_count - 1)
      expect(flash[:success]).to eq("Rover destroyed!")
      expect(response).to redirect_to(plateau)
    end
  end

  describe "PATCH /update_position" do
    context "with valid movement instructions" do

      it "changes the heading from N to E" do
        patch '/update_position', params: { movement_instruction: "R", id: rover.id }
        rover.reload
        expect(rover.heading).to eq("E")
      end

      it "changes the heading from N to W" do
        patch '/update_position', params: { movement_instruction: "L", id: rover.id }
        rover.reload
        expect(rover.heading).to eq("W")
      end

      it "changes the y_coordinate value by 1" do
        old_y_coordinate = rover.y_coordinate
        patch '/update_position', params: { movement_instruction: "M", id: rover.id }
        rover.reload
        expect(rover.y_coordinate).to eq(old_y_coordinate + 1)
      end

      it "changes the x_coordinate value by 1" do
        old_x_coordinate = rover.x_coordinate
        patch '/update_position', params: { movement_instruction: "RM", id: rover.id }
        rover.reload
        expect(rover.x_coordinate).to eq(old_x_coordinate + 1)
      end

      it "changes the heading to E, the x_coordinate to 0 and the y_coordinate to 0" do
        patch '/update_position', params: { movement_instruction: "LMMMMMLMMMMRRR", id: rover.id }
        rover.reload
        expect(rover.heading).to eq("E")
        expect(rover.x_coordinate).to eq(0)
        expect(rover.y_coordinate).to eq(0)
      end
    end

    context "with invalid movement instructions consisting of characters that aren't exclusively L, R, M" do

      it "flashes an error message and doesn't update the rover position or heading" do
        original_heading = rover.heading
        original_x_coordinate = rover.x_coordinate
        original_y_coordinate = rover.y_coordinate
        patch '/update_position', params: { movement_instruction: "XLM$j:?((999HJRMRMRMRMRMRL", id: rover.id }
        expect(flash[:danger]).to eq("Incorrect movement instructions!")
        rover.reload
        expect(original_heading).to eq(rover.heading)
        expect(original_x_coordinate).to eq(rover.x_coordinate)
        expect(original_y_coordinate).to eq(rover.y_coordinate)
      end
    end

    context "when movement instructions take rover outside of plateau boundary" do
      
      it "flashes an error message relating to the rover's x-axis position and doesn't update the rover position" do
        original_x_coordinate = rover.x_coordinate
        patch '/update_position', params: { movement_instruction: "RMMMMMMMMMMMMMMMMMMMMM", id: rover.id }
        expect(flash[:danger]).to eq("X coordinate can't be greater than the plateau top right x coordinate!")
        expect(rover.x_coordinate).to eq(original_x_coordinate)
      end

      it "flashes an error message relating to the rover's y-axis position and doesn't update the rover position" do
        original_y_coordinate = rover.y_coordinate
        patch '/update_position', params: { movement_instruction: "MMMMMMMMMMMMMMMMMMMMMMMMMMMM", id: rover.id }
        expect(flash[:danger]).to eq("Y coordinate can't be greater than the plateau top right y coordinate!")
        expect(rover.y_coordinate).to eq(original_y_coordinate)
      end
    end
  end
end