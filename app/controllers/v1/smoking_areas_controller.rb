class V1::SmokingAreasController < ApplicationController
  def index
    smoking_areas = SmokingArea.order(:id).includes(:tobacco_types)

    # たばこ種別フィルタ（tobacco_type_id が指定された場合）
    if params[:tobacco_type_id].present?
      smoking_areas = smoking_areas
        .joins(:tobacco_types)
        .where(tobacco_types: { id: params[:tobacco_type_id] })
    end

    # 名前検索（query が指定されていて、実質的な文字がある場合）
    if params[:query].present?
      query = params[:query].squish  # 前後の空白 + 連続空白 + 全角スペースも正規化
      if query != ""
        smoking_areas = smoking_areas.where("smoking_areas.name ILIKE ?", "%#{query}%")
      end
    end

    # join で重複する可能性があるので distinct、
    # かつ既存仕様どおり id 昇順で返す
    smoking_areas = smoking_areas.distinct.order(:id)

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
