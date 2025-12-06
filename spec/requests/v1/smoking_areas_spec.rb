require 'rails_helper'

RSpec.describe "V1::SmokingAreas", type: :request do
  describe "GET /v1/smoking_areas" do
    it "returns information necessary to display smoking areas" do

      electronic = TobaccoType.create!(name: "電子タバコ", icon: "electronic cigarette", display_order: 2)
      paper      = TobaccoType.create!(name: "紙タバコ",   icon: "cigarette",            display_order: 1)

      smoking_area1 = SmokingArea.create!(name: "新宿東口喫煙所",       latitude: 36.666333,  longitude: 135.343434)
      smoking_area2 = SmokingArea.create!(name: "鳥貴族町田北口店",     latitude: 35.123456,  longitude: 134.987654)
      smoking_area3 = SmokingArea.create!(name: "ニトリモール相模原1F", latitude: 35.555555,  longitude: 139.777333)

      SmokingAreaTobaccoType.create!(smoking_area: smoking_area1, tobacco_type: paper)
      SmokingAreaTobaccoType.create!(smoking_area: smoking_area1, tobacco_type: electronic)
      SmokingAreaTobaccoType.create!(smoking_area: smoking_area2, tobacco_type: paper)
      SmokingAreaTobaccoType.create!(smoking_area: smoking_area2, tobacco_type: electronic)
      SmokingAreaTobaccoType.create!(smoking_area: smoking_area3, tobacco_type: electronic)

      get "/v1/smoking_areas"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.size).to eq 3
      expect(json.map { |smoking_area_json| smoking_area_json["name"] }).to eq [
        smoking_area1.name,
        smoking_area2.name,
        smoking_area3.name
      ]

      first = json.first
      expect(first["tobacco_type_ids"]).to eq [paper.id, electronic.id]

      json.each do |smoking_area_json|
        expect(smoking_area_json.keys.sort).to eq %w[id name latitude longitude tobacco_type_ids].sort
      end
    end
  end
end
