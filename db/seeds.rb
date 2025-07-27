TobaccoType.create!([
    {kinds: "紙タバコ"},
    {kinds: "電子タバコ"}
])

SmokingAreaStatus.create!([
    {name: "公開中"},
    {name: "公開停止中"}
])

ReportStatus.create!([
    {name: "対応前"},
    {name: "対応済み"},
    {name: "対応中"}
])

SmokingAreaType.create!([
    {name: "公共", icon: "public", color: "#1976D2"},
    {name: "施設内", icon: "mall", color: "#43A047"},
    {name: "飲食店", icon: "restaurant", color: "#8D6E63"},
    {name: "カフェ", icon: "cafe", color: "#795548"}
    {name: "コンビニ", icon: "convenience", color: "#FB8C00"},
    {name: "その他", icon: "other", color: "#9E9E9E"}
])