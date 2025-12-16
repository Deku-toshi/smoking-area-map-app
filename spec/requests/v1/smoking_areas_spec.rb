require 'rails_helper'

RSpec.describe "V1::SmokingAreas", type: :request do
  describe "GET /v1/smoking_areas" do
    it "returns smoking areas" do

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
      second = json.second
      expect(second["tobacco_type_ids"]).to eq [paper.id, electronic.id]

      json.each do |smoking_area_json|
        expect(smoking_area_json.keys.sort).to eq %w[id name latitude longitude tobacco_type_ids].sort
      end
    end

    it "filters smoking areas by tobacco_type_id" do
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

      get "/v1/smoking_areas", params: { tobacco_type_id: paper.id }

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      # 紙タバコに紐づく喫煙所だけが返ること
      expect(json.size).to eq 2
      expect(json.map { |smoking_area_json| smoking_area_json["name"] }).to match_array [
        smoking_area1.name,
        smoking_area2.name
      ]
      json.each do |smoking_area_json|
        expect(smoking_area_json["tobacco_type_ids"]).to include(paper.id)
      end
    end

    it "filters smoking areas by query on name" do
      electronic = TobaccoType.create!(name: "電子タバコ", icon: "electronic cigarette", display_order: 2)
      paper      = TobaccoType.create!(name: "紙タバコ",   icon: "cigarette",            display_order: 1)
      
      shinjuku_east   = SmokingArea.create!(name: "新宿東口喫煙所",    latitude: 36.666333, longitude: 135.343434)
      shinjuku_sanchome = SmokingArea.create!(name: "新宿三丁目喫煙所", latitude: 36.666334, longitude: 135.343435)
      machida_north   = SmokingArea.create!(name: "町田駅北口喫煙所",  latitude: 35.123456, longitude: 134.987654)

      [shinjuku_east, shinjuku_sanchome, machida_north].each do |area|
        SmokingAreaTobaccoType.create!(smoking_area: area, tobacco_type: paper)
        SmokingAreaTobaccoType.create!(smoking_area: area, tobacco_type: electronic)
      end

      get "/v1/smoking_areas", params: { query: "新宿" }

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      # name に「新宿」を含む喫煙所だけが返ること
      expect(json.size).to eq 2
      expect(json.map { |smoking_area_json| smoking_area_json["name"] }).to match_array [
        shinjuku_east.name,
        shinjuku_sanchome.name
      ]
    end

    it "filters smoking areas by both tobacco_type_id and query" do
      electronic = TobaccoType.create!(name: "電子タバコ", icon: "electronic cigarette", display_order: 2)
      paper      = TobaccoType.create!(name: "紙タバコ",   icon: "cigarette",            display_order: 1)
      
      shinjuku_both = SmokingArea.create!(name: "新宿東口喫煙所",    latitude: 36.666333, longitude: 135.343434)
      shinjuku_electronic_only = SmokingArea.create!(name: "新宿西口喫煙所", latitude: 36.666334, longitude: 135.343435)
      machida_paper_only = SmokingArea.create!(name: "町田駅北口喫煙所",  latitude: 35.123456, longitude: 134.987654)

      # 新宿東口: 紙 + 電子
      SmokingAreaTobaccoType.create!(smoking_area: shinjuku_both, tobacco_type: paper)
      SmokingAreaTobaccoType.create!(smoking_area: shinjuku_both, tobacco_type: electronic)
      # 新宿西口: 電子のみ
      SmokingAreaTobaccoType.create!(smoking_area: shinjuku_electronic_only, tobacco_type: electronic)
      # 町田北口: 紙のみ
      SmokingAreaTobaccoType.create!(smoking_area: machida_paper_only, tobacco_type: paper)

      get "/v1/smoking_areas", params: { tobacco_type_id: paper.id, query: "新宿" }

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      # 「新宿」を含み、かつ紙タバコに対応している喫煙所だけが返ること
      expect(json.size).to eq 1
      expect(json.first["name"]).to eq shinjuku_both.name
      expect(json.first["tobacco_type_ids"]).to include(paper.id)
    end
  end

  describe "GET /v1/smoking_areas/:id" do
    context "when the resource exists" do
      it "returns smoking area details" do
      
        paper      = TobaccoType.create!(name: "紙タバコ",   icon: "cigarette",            display_order: 1)
        electronic = TobaccoType.create!(name: "電子タバコ", icon: "electronic cigarette", display_order: 2)

        smoking_area1 = SmokingArea.create!(name: "新宿東口喫煙所", latitude: 36.666333, longitude: 135.343434, 
                                            is_indoor: true, detail: "広い", address: "〒160-0022 東京都新宿区新宿３丁目３８")
                                            
        SmokingAreaTobaccoType.create!(smoking_area: smoking_area1, tobacco_type: paper)
        SmokingAreaTobaccoType.create!(smoking_area: smoking_area1, tobacco_type: electronic)

        get "/v1/smoking_areas/#{smoking_area1.id}"

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)

        expect(json["id"]).to eq smoking_area1.id
        expect(json["name"]).to eq smoking_area1.name
        expect(json["latitude"]).to eq smoking_area1.latitude.to_s
        expect(json["longitude"]).to eq smoking_area1.longitude.to_s
        expect(json["is_indoor"]).to eq smoking_area1.is_indoor
        expect(json["detail"]).to eq smoking_area1.detail
        expect(json["address"]).to eq smoking_area1.address

        tobacco_types = json["tobacco_types"]

        expect(tobacco_types.size).to eq 2
        expect(tobacco_types.map { |tobacco_type| tobacco_type["id"] }).to   eq [paper.id, electronic.id]
        expect(tobacco_types.map { |tobacco_type| tobacco_type["name"] }).to eq ["紙タバコ", "電子タバコ"]
        expect(tobacco_types.map { |tobacco_type| tobacco_type["icon"] }).to eq ["cigarette", "electronic cigarette"]
      end
    end
    
    context "when the resource does not exist" do
      it "returns 404 when smoking area does not exist" do
        non_existing_id = SmokingArea.maximum(:id).to_i + 1

        get "/v1/smoking_areas/#{non_existing_id}"

        expect(response).to have_http_status(:not_found)

        json = JSON.parse(response.body)

        expect(json["error"]["code"]).to eq "not_found"
        expect(json["error"]["message"]).to eq "Smoking area not found."
        expect(json["request_id"]).to be_present
      end
    end
  end
end
