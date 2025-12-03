class V1::TobaccoTypesController < ApplicationController
  def index
    tobacco_types = TobaccoType.order(:display_order)
    render json: tobacco_types.as_json(only: %i[id name icon display_order])
  end
end