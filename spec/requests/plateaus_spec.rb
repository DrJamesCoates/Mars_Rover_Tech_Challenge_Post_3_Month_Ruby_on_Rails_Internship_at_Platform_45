require 'rails_helper'

RSpec.describe "Plateaus", type: :request do

  let(:plateau_for_update) { create(:plateau) }
  let(:plateau_for_delete) { create(:plateau) }

  let(:valid_params) do
    { name: "Hella plateau", top_right_x_coordinate: 10, top_right_y_coordinate: 15, :explored=>false }
  end
  let(:invalid_params) do
    [
      { name: nil, top_right_x_coordinate: 10, top_right_y_coordinate: 8, explored: false },
      { name: "Valid name", top_right_x_coordinate: nil, top_right_y_coordinate: 8, explored: false },
      { name: "Valid name", top_right_x_coordinate: 10, top_right_y_coordinate: nil, explored: false },
      { name: "Valid name", top_right_x_coordinate: 10, top_right_y_coordinate: 8, explored: nil },
      { name: "Valid name", top_right_x_coordinate: 10, top_right_y_coordinate: 10, explored: true }
    ]
  end

  let(:valid_update_params) do
    { name: "BIG NAME", top_right_x_coordinate: 888, top_right_y_coordinate: 444, explored: true }
  end

  describe "POST /plateaus" do
    context "with correct plateau attributes" do
      it "successfully creates plateau, flashes a success message and redirects to the plateau show view" do
        old_plateau_count = Plateau.count
        post '/plateaus', params: valid_params
        expect(Plateau.count).to eq(old_plateau_count + 1)
        expect(flash[:success]).to eq('Plateau created!')
        expect(response).to redirect_to(plateau_url(Plateau.first.id))
      end
    end

    context "with incorrect plateau attributes" do
      it "does not create a plateau and it renders an error message related to blank name" do
        old_plateau_count = Plateau.count
        post '/plateaus', params: invalid_params[0]
        expect(Plateau.count).to eq(old_plateau_count)
        expect(flash[:danger]).to eq("Name can't be blank")
      end

      it "does not create a plateau and it renders an error message related to absent top right x coordinate" do
        old_plateau_count = Plateau.count
        post '/plateaus', params: invalid_params[1]
        expect(Plateau.count).to eq(old_plateau_count)
        expect(flash[:danger]).to eq("Top right x coordinate can't be blank")
      end

      it "does not create a plateau and it renders an error message related to absent top right y coordinate" do
        old_plateau_count = Plateau.count
        post '/plateaus', params: invalid_params[2]
        expect(Plateau.count).to eq(old_plateau_count)
        expect(flash[:danger]).to eq("Top right y coordinate can't be blank")
      end

      it "does not create a plateau and it renders an error message related to explored status" do
        old_plateau_count = Plateau.count
        post '/plateaus', params: invalid_params[3]
        expect(Plateau.count).to eq(old_plateau_count)
        expect(flash[:danger]).to eq("Explored is not included in the list")
      end

      it "does not create a plateau and it renders an error message related to top right coordinates being equal" do
        old_plateau_count = Plateau.count
        post '/plateaus', params: invalid_params[4]
        expect(Plateau.count).to eq(old_plateau_count)
        expect(flash[:danger]).to eq("Plateau must be a rectangel: top right x and y coordinates cannot be equal!")
      end
    end
  end

  describe "PATCH /plateaus/:id" do
    context "with valid update attributes" do
      it "updates the plateau attributes, flashes a success message and redirects to the plateau show view" do
        plateau = plateau_for_update
        expect(plateau.name).not_to eq(valid_update_params[:name])
        expect(plateau.top_right_x_coordinate).not_to eq(valid_update_params[:top_right_x_coordinate])
        expect(plateau.top_right_y_coordinate).not_to eq(valid_update_params[:top_right_y_coordinate])
        expect(plateau.explored).not_to eq(valid_update_params[:explored])

        patch "/plateaus/#{plateau.id}", params: valid_update_params
        plateau.reload

        expect(flash[:success]).to eq("Plateau updated!")
        expect(response).to redirect_to(plateau_url(plateau.id))
        expect(plateau.name).to eq(valid_update_params[:name])
        expect(plateau.top_right_x_coordinate).to eq(valid_update_params[:top_right_x_coordinate])
        expect(plateau.top_right_y_coordinate).to eq(valid_update_params[:top_right_y_coordinate])
        expect(plateau.explored).to eq(valid_update_params[:explored])
      end
    end

    context "with invalid update attributes" do
      it "does not update the plateau attributes and renders an error message" do
        plateau = plateau_for_update
        patch "/plateaus/#{plateau.id}", params: { name: nil }
        expect(flash[:danger]).to eq("Could not update plateau")
        expect(plateau.name).not_to be_nil

        patch "/plateaus/#{plateau.id}", params: { top_right_x_coordinate: nil }
        expect(flash[:danger]).to eq("Could not update plateau")
        expect(plateau.top_right_x_coordinate).not_to be_nil

        patch "/plateaus/#{plateau.id}", params: { top_right_y_coordinate: nil }
        expect(flash[:danger]).to eq("Could not update plateau")
        expect(plateau.top_right_y_coordinate).not_to be_nil

        patch "/plateaus/#{plateau.id}", params: { explored: nil }
        expect(flash[:danger]).to eq("Could not update plateau")
        expect(plateau.explored).not_to be_nil
      end
    end
  end

  describe "DELETE /plateaus/:id" do
    it "reduces the plateau count by 1, flashes a success message and redirects to plateaus index view" do
      plateau = plateau_for_delete
      plateau_count_before_delete = Plateau.count
      delete "/plateaus/#{plateau.id}"
      expect(Plateau.count).to eq(plateau_count_before_delete - 1)
      expect(flash[:success]).to eq("Plateau deleted!")
      expect(response).to redirect_to(plateaus_url)
    end
  end
end
