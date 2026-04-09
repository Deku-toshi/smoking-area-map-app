import { useState, useEffect } from "react";
import { useSmokingAreas } from "./features/smokingAreas/hooks/useSmokingAreas";
import { useTobaccoTypes } from "./features/smokingAreas/hooks/useTobaccoTypes";
import { SmokingAreasMap } from "./SmokingAreasMap";
import type { SmokingAreaSearchParams } from "./features/smokingAreas/types"

export default function App() {
  const [ params, setParams ] = useState<SmokingAreaSearchParams>({});
  const [ selectedId, setSelectedId ] = useState<number | null>(null);

  const { data, isLoading, error, refetch } = useSmokingAreas(params);
  const { data: tobaccoTypes } = useTobaccoTypes();

  useEffect(() => {
    if (selectedId === null) return;
    const found = data.find((area) => area.id === selectedId);
    if (!found) setSelectedId(null);
    // dataが変わったとき（タバコ種別フィルターでの変更時）のみ実行し、選択中のidをリセット
    // selectedIdの変化には反応不要のため依存配列から除外（ESLint導入時はdisableコメントを追加）
  }, [data]);

  return (
    <SmokingAreasMap
      smokingAreas={data}
      selectedId={selectedId}
      setSelectedId={setSelectedId}
      tobaccoTypes={tobaccoTypes ?? []}
      params={params}
      setParams={setParams}
      isLoading={isLoading}
      error={error}
      refetch={refetch}
    />
  );
}
