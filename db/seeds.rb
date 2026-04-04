ActiveRecord::Base.transaction do  
  tobacco_type_definitions = [
    {name: "紙タバコ",   icon: "cigarette",            display_order: 1},
    {name: "電子タバコ", icon: "electronic cigarette", display_order: 2}
  ].freeze

  tobacco_type_definitions.each do |tobacco_type_attrs|
    tobacco_type = TobaccoType.find_or_initialize_by(name: tobacco_type_attrs[:name])
    tobacco_type.assign_attributes(tobacco_type_attrs.except(:name)
    )
    tobacco_type.save!
  end

  tobacco_types_by_key = {
    paper:      TobaccoType.find_by!(name: "紙タバコ"),
    electronic: TobaccoType.find_by!(name: "電子タバコ")
  }


  #以下喫煙所実データ
  smoking_area_definitions= [
    {
      name: "新宿駅東口新宿区公共喫煙所",
      latitude:  35.6923331,
      longitude: 139.700632,
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "西新宿駅正面口喫煙所",
      latitude:  35.693893,
      longitude: 139.700316,
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "新宿駅西口喫煙所",
      latitude: 35.691371,
      longitude: 139.698169,
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "ドトール 新大手町ビル店",
      latitude: 35.685264,
      longitude: 139.767210,
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "カフェ・ド・クリエ 丸の内明治安田生命ビル店",
      latitude: 35.679155,
      longitude: 139.762077,
      tobacco_keys: %i[electronic]
    },
    {
      name: "はとバス東京営業所 喫煙所",
      latitude: 35.679650,
      longitude: 139.765889,
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "渋谷駅前スクランブル交差点喫煙所",
      latitude: 35.659454,
      longitude: 139.700112,
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "宮益坂下交差点喫煙所",
      latitude: 35.659794,
      longitude: 139.702250,
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "渋谷駅モヤイ像",
      latitude: 35.658498,
      longitude: 139.700919,
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "池袋駅東口喫煙所",
      latitude: 35.730365,
      longitude: 139.712765,
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "池袋駅北口喫煙所",
      latitude: 35.731783,
      longitude: 139.711388,
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "池袋駅西口東京芸術劇場前喫煙所",
      latitude: 35.730557,
      longitude: 139.708041,
      tobacco_keys: %i[paper electronic]
    }
  ].freeze

  smoking_area_definitions.each do |smoking_area_def|
    tobacco_keys       = smoking_area_def.fetch(:tobacco_keys)
    smoking_area_attrs = smoking_area_def.except(:tobacco_keys)

    smoking_area = SmokingArea.find_or_initialize_by(
      name:      smoking_area_attrs[:name],
      latitude:  smoking_area_attrs[:latitude],
      longitude: smoking_area_attrs[:longitude]
    )
    smoking_area.assign_attributes(smoking_area_attrs)
    smoking_area.save!

    smoking_area.smoking_area_tobacco_types.destroy_all
    tobacco_keys.each do |tobacco_type_key|
      SmokingAreaTobaccoType.create!(
        smoking_area: smoking_area,
        tobacco_type: tobacco_types_by_key.fetch(tobacco_type_key)
      )
    end
  end
end
