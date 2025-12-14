class V1::SmokingAreasController < ApplicationController
  def index
    smoking_areas = SmokingArea.order(:id).includes(:tobacco_types)

    render json: (smoking_areas.map do |smoking_area|
      {
        id:   smoking_area.id,
        name: smoking_area.name,
        latitude:  smoking_area.latitude,
        longitude: smoking_area.longitude,
        tobacco_type_ids: smoking_area.tobacco_types.map { |tobacco_type| tobacco_type.id }
      }
    }
  end
end
