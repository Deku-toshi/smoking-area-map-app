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
    end)
  end

  def show
    smoking_area = SmokingArea.includes(:tobacco_types).find(params[:id])

    render json: { 
      id:   smoking_area.id,
      name: smoking_area.name,
      latitude:  smoking_area.latitude,
      longitude: smoking_area.longitude,
      is_indoor: smoking_area.is_indoor,
      detail:    smoking_area.detail,
      address:   smoking_area.address,
      tobacco_types: smoking_area.tobacco_types.map do |tobacco_type|
         {
           id:   tobacco_type.id,
           name: tobacco_type.name,
           icon: tobacco_type.icon
         }
      end
    }
  end
end
