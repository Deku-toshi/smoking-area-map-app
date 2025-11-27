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


  #以下喫煙所仮データ
  smoking_area_definitions= [
    {
      name: "新宿駅東口新宿区公共喫煙所",
      latitude:  35.691123,
      longitude: 139.703456,
      detail: "東口出てすぐ。広くて人が多く汚い",
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "西新宿駅正面口喫煙所",
      latitude:  35.693893,
      longitude: 139.700316,
      detail: "西新宿駅正面口の目の前にある。広くて人が多いが、新宿駅東口新宿区公共喫煙所よりは綺麗",
      tobacco_keys: %i[paper electronic]
    },
    {
      name: "新宿駅西口喫煙所",
      latitude: 35.691444,
      longitude: 139.698987,
      detail: "場所が少しわかりづらい",
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

    tobacco_keys.each do |tobacco_type_key|
      SmokingAreaTobaccoType.find_or_create_by!(
        smoking_area: smoking_area,
        tobacco_type: tobacco_types_by_key.fetch(tobacco_type_key)
      )
    end
  end
end