types = [
  { kinds: "紙タバコ", icon: "🚬"},
  { kinds: "電子タバコ", icon: "電子"}
]

types.each do |attrs|
  rec = TobaccoType.find_or_initialize_by(kinds: attrs[:kinds])
  rec.assign_attributes(icon: attrs[:icon])
  rec.save! if rec.changed?
end


%w[公開中 公開停止中].each do |n|
  SmokingAreaStatus.find_or_create_by!(name: n)
end

%w[対応前 対応済み 対応中].each do |n|
  ReportStatus.find_or_create_by!(name: n)
end



SmokingAreaTypeData = [
  {code: "public",      name: "公共",     icon: "public",      color: "#1976D2"},
  {code: "mall",        name: "施設内",   icon: "mall",        color: "#43A047"},
  {code: "restaurant",  name: "飲食店",   icon: "restaurant",  color: "#8D6E63"},
  {code: "cafe",        name: "カフェ",   icon: "cafe",        color: "#795548"},
  {code: "convenience", name: "コンビニ", icon: "convenience", color: "#FB8C00"},
  {code: "other",       name: "その他",   icon: "other",       color: "#9E9E9E"}
].freeze



SmokingAreaTypeData.each do |row|
  r = row.transform_keys(&:to_sym)
  rec = SmokingAreaType.find_or_initialize_by(code: r[:code])
  rec.assign_attributes(
    name:  r[:name],
    icon:  r[:icon],
    color: r[:color]
  )
  rec.save! if rec.changed?
end


#以下仮データ
user = User.find_or_create_by!(email: "test@example.com") do |u|
  u.password = "password"
  u.name     = "テストユーザー"
end

status = SmokingAreaStatus.find_by!(name: "公開中")
area_type   = SmokingAreaType.find_by!(code: "public")

paper  = TobaccoType.find_by!(kinds: "紙タバコ")
ecig   = TobaccoType.find_by!(kinds: "電子タバコ")

shinjuku_east_24h = SmokingArea.find_or_initialize_by(
  name: "新宿駅東口（24時間）", 
  address: "東京都新宿区新宿3丁目38"
)
shinjuku_east_24h.assign_attributes(
  user:                user,
  smoking_area_status: status,
  smoking_area_type:   area_type,
  latitude:            35.6895,
  longitude:           139.6917,
  available_time_type: :always
)
shinjuku_east_24h.save! if shinjuku_east_24h.changed?
shinjuku_east_24h.tobacco_types = [paper, ecig]

shinjuku_east_business = SmokingArea.find_or_initialize_by(
  name: "新宿駅東口（時間指定 08:00-20:00）", 
  address: "東京都新宿区新宿3丁目38"
)
shinjuku_east_business.assign_attributes(
  user:                user,
  smoking_area_status: status,
  smoking_area_type:   area_type,
  latitude:            35.6895,
  longitude:           139.6917,
  available_time_type:  :business,
  available_time_start: "08:00",
  available_time_end:   "20:00"
)
shinjuku_east_business.save! if shinjuku_east_business.changed?
shinjuku_east_business.tobacco_types = [ecig]