TobaccoType.find_or_create_by!(kinds: "紙タバコ") do |t|
    t.icon = "🚬"
end

TobaccoType.find_or_create_by!(kinds: "電子タバコ") do |t|
    t.icon = "電子"
end

SmokingAreaStatus.find_or_create_by!(name: "公開中")

SmokingAreaStatus.find_or_create_by!(name: "公開停止中")


ReportStatus.find_or_create_by!(name: "対応前")

ReportStatus.find_or_create_by!(name: "対応済み")

ReportStatus.find_or_create_by!(name: "対応中")


SmokingAreaTypeData = [
    {name: "公共", icon: "public", color: "#1976D2"},
    {name: "施設内", icon: "mall", color: "#43A047"},
    {name: "飲食店", icon: "restaurant", color: "#8D6E63"},
    {name: "カフェ", icon: "cafe", color: "#795548"},
    {name: "コンビニ", icon: "convenience", color: "#FB8C00"},
    {name: "その他", icon: "other", color: "#9E9E9E"}
]

SmokingAreaTypeData.each do |data|
    type = SmokingAreaType.find_or_initialize_by(name: data[:name])
    type.icon = data[:icon]
    type.color = data[:color]
    type.save!
end