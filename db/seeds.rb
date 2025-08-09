t = TobaccoType.find_or_initialize_by(kinds: "紙タバコ")
t.icon = "🚬"
t.save!

t = TobaccoType.find_or_initialize_by(kinds: "電子タバコ")
t.icon = "電子"
t.save!

SmokingAreaStatus.find_or_create_by!(name: "公開中")
SmokingAreaStatus.find_or_create_by!(name: "公開停止中")

ReportStatus.find_or_create_by!(name: "対応前")
ReportStatus.find_or_create_by!(name: "対応済み")
ReportStatus.find_or_create_by!(name: "対応中")

SmokingAreaTypeData = [
  {name: "公共",   icon: "public",      color: "#1976D2"},
  {name: "施設内", icon: "mall",        color: "#43A047"},
  {name: "飲食店", icon: "restaurant",  color: "#8D6E63"},
  {name: "カフェ", icon: "cafe",        color: "#795548"},
  {name: "コンビニ", icon: "convenience", color: "#FB8C00"},
  {name: "その他", icon: "other",       color: "#9E9E9E"}
]
SmokingAreaTypeData.each do |data|
  type = SmokingAreaType.find_or_initialize_by(name: data[:name])
  type.icon  = data[:icon]
  type.color = data[:color]
  type.save!
end

#以下仮データ
user = User.find_or_create_by!(email: "test@example.com") do |u|
  u.password = "password"
  u.name     = "テストユーザー"
end

status = SmokingAreaStatus.find_by!(name: "公開中")
type   = SmokingAreaType.find_by!(name: "公共")

paper  = TobaccoType.find_by!(kinds: "紙タバコ")
ecig   = TobaccoType.find_by!(kinds: "電子タバコ")

smk = SmokingArea.find_or_initialize_by(name: "新宿駅東口", address: "東京都新宿区新宿3丁目38")
smk.assign_attributes(
  user:                user,
  smoking_area_status: status,
  smoking_area_type:   type,
  latitude:            35.6895,
  longitude:           139.6917
)
smk.save!
smk.tobacco_types = [paper, ecig]
