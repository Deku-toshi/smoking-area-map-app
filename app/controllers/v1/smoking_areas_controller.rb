class V1::SmokingAreasController < ApplicationController
  def index
    smoking_areas = SmokingArea.all

    if params[:electronic_only].present?
      paper_id      = TobaccoType.find_by!(name: "紙タバコ").id
      electronic_id = TobaccoType.find_by!(name: "電子タバコ").id

      smoking_areas = smoking_areas
        .joins(:tobacco_types)
        .where(tobacco_types: { id: electronic_id })
        .where.not(id: SmokingArea.joins(:tobacco_types).where(tobacco_types: { id: paper_id }))
    
    elsif params[:tobacco_type_id].present?
      filtered_ids = SmokingArea
        .joins(:tobacco_types)
        .where(tobacco_types: { id: params[:tobacco_type_id]})
        .select(:id)
      smoking_areas = smoking_areas.where(id: filtered_ids)
    end

    smoking_areas = smoking_areas.includes(:tobacco_types).distinct.order(:id)

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
