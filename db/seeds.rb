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


HEX6 = /\A#[0-9A-Fa-f]{6}\z/

SmokingAreaTypeData = [
  {code: "public",      name: "公共",     icon: "public",      color: "#1976D2"},
  {code: "mall",        name: "施設内",   icon: "mall",        color: "#43A047"},
  {code: "restaurant",  name: "飲食店",   icon: "restaurant",  color: "#8D6E63"},
  {code: "cafe",        name: "カフェ",   icon: "cafe",        color: "#795548"},
  {code: "convenience", name: "コンビニ", icon: "convenience", color: "#FB8C00"},
  {code: "other",       name: "その他",   icon: "other",       color: "#9E9E9E"}
]


SmokingAreaTypeData.each do |row|
  r = row.transform_keys(&:to_sym)
  %i[code name icon color].each do |k|
    raise "SmokingAreaTypeData missing #{k}: #{row.inspect}" if r[k].to_s.strip.empty?
  end
  raise "Invalid color format: #{r[:color]} (code=#{r[:code]})" unless r[:color].match?(HEX6)
end

SmokingAreaType.transaction do
  SmokingAreaType.delete_all
  SmokingAreaTypeData.each do |row|
    r = row.transform_keys(&:to_sym)
    SmokingAreaType.create!(
      code:  r[:code],
      name:  r[:name],
      icon:  r[:icon],
      color: r[:color]
    )
  end
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
