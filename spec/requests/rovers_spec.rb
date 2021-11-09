require 'rails_helper'

RSpec.describe "Rovers", type: :request do
  
  let!(:plateau) { create(:plateau) }
  let(:valid_attributes) do
    { name: "Valid name", heading: "N", x_coordinate: 10, y_coordinate: 2 }
  end
  let(:invalid_attributes) do
    [
      { name: nil, heading: "N", x_coordinate: 10, y_coordinate: 2 },
      { name: "Valid name", heading: "X", x_coordinate: 10, y_coordinate: 2 }, 
      { name: "Valid name", heading: "N", x_coordinate: nil, y_coordinate: 2 },
      { name: "Valid name", heading: "N", x_coordinate: 10, y_coordinate: nil }
    ]
  end
  let(:valid_update_attributes) do
    { name: "Valid update name", heading: "S", x_coordinate: 12, y_coordinate: 13 }
  end
  let(:invalid_update_attributes) do
    { name: nil, heading: "v", x_coordinate: nil, y_coordinate: nil }
  end

  describe "POST /plateaus/:id/rovers" do
    context "with valid attributes" do
      it "should flash a success message, increment the rovers count by 1 and redirect to the plateau show view" do
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
        invalid_attributes.each do | invalid_attributes_hash |
          post "/plateaus/#{plateau.id}/rovers", params: invalid_attributes_hash
          expect(flash[:danger]).to eq("Could not create rover")
          expect(Rover.count).to eq(old_rover_count)
        end
      end
    end
  end

  describe "PATCH /plateaus/:id/rovers/:id" do
    
    context "with valid update attributes" do
      it "updates the rover, flashes a success message and redirects to the plateau show view" do
        post "/plateaus/#{plateau.id}/rovers", params: valid_attributes
        rover = plateau.rovers.first
        patch "/plateaus/#{plateau.id}/rovers/#{rover.id}", params: valid_update_attributes
        
        rover.reload
        expect(rover.name).to eq(valid_update_attributes[:name])
        expect(rover.x_coordinate).to eq(valid_update_attributes[:x_coordinate])
        expect(rover.y_coordinate).to eq(valid_update_attributes[:y_coordinate])
        expect(rover.heading).to eq(valid_update_attributes[:heading])
        expect(flash[:success]).to eq("Rover updated!")
        expect(response).to redirect_to(plateau)
      end
    end

    context "with invalid_update_attributes" do
      it "flashes an error messsage and does not update the rover attribrutes" do
        post "/plateaus/#{plateau.id}/rovers", params: valid_attributes
        rover = plateau.rovers.first

        patch "/plateaus/#{plateau.id}/rovers/#{rover.id}", params: invalid_update_attributes
        expect(flash[:danger]).to eq("Could not update rover")
        rover.reload

        expect(rover.name).not_to be_nil
        expect(rover.heading).not_to eq(invalid_update_attributes[:heading])
        expect(rover.x_coordinate).not_to be_nil
        expect(rover.y_coordinate).not_to be_nil
      end
    end
  end

  describe "DELETE /plateaus/:id/rovers/:id" do
    it "reduces the rover count by 1, renders a success message and redirects to the plateau show view" do
      post "/plateaus/#{plateau.id}/rovers", params: valid_attributes
      rover = plateau.rovers.first
      old_rover_count = Rover.count
      delete "/plateaus/#{plateau.id}/rovers/#{rover.id}"
      expect(Rover.count).to eq(old_rover_count - 1)
      expect(flash[:success]).to eq("Rover destroyed!")
      expect(response).to redirect_to(plateau)
    end
  end
end