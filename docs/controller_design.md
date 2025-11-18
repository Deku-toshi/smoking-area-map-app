# v0.1 コントローラー設計

## 対象エンドポイント
- GET /v1/smoking_areas
- GET /v1/smoking_areas/{id}
- GET /v1/tobacco_types

## Api::V1::SmokingAreasController

### index
- Params
    - lat, lng (必須)
    - tobacco_type_ids[], radius_m, q, sort, page, per_page

- 処理の流れ
    1.パラメータの型・範囲をバリデーション(lat / lng, radius_m, sort, page, per_page など。不正時は 400 invalid_param)
    2.tobacco_type_ids[]（タバコ種別）が指定されていれば、中間テーブル経由で該当喫煙所だけをDB側の絞り込みで残す
    3.q が指定されていれば、name の部分一致でさらに絞り込み
    4.位置情報(lat, lng)と radius_m で距離(distance_m)を計算し、範囲内(既定:1000m, [100, 3000] でclamp)の喫煙所に絞る
    5.sort で distance_asc が指定されている場合は、distance_m の昇順で並び替え、page / per_page でページネーションして返す

### show
- Params
  - id : integer(必須、path)

- 処理の流れ
    1.URLパスの id から対象の喫煙所を1件取得する
    2.見つからない場合は 404 not_found エラーを返す
    3.取得した喫煙所の位置(lat, lng)と基本情報（name, is_indoor, detail, tobacco_types[{id, name, icon}]）をJSONで返す


## Api::V1::TobaccoTypesController

### index
- Params
    - クエリパラメータはなし

- 処理の流れ
    1.タバコ種別マスタを全件取得する
    2.display_order 昇順で並び替える（紙タバコ → 電子タバコ の順）
    3.{id, name, icon} を JSON の配列として返す（フィルタUIでアイコンを表示する前提）