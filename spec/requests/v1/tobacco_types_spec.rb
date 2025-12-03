require 'rails_helper'

RSpec.describe "V1::TobaccoTypes", type: :request do
  describe "GET /v1/tobacco_types" do
    it "returns tobacco types sorted by display_order with only allowed fields" do

      TobaccoType.create!(name: "電子タバコ", icon: "electronic cigarette", display_order: 2)
      TobaccoType.create!(name: "紙タバコ",   icon: "cigarette",            display_order: 1)

      get "/v1/tobacco_types"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.size).to eq 2

      expect(json.map { |t| t["name"] }).to eq ["紙タバコ", "電子タバコ"]
      expect(json.map { |t| t["display_order"] }).to eq [1, 2]

      json.each do |t|
        expect(t.keys.sort).to eq %w[id name icon display_order].sort
      end
    end
  end
end