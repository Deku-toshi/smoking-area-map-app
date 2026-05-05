import { useState, useEffect } from "react";
import { useSmokingAreas } from "./features/smokingAreas/hooks/useSmokingAreas";
import { SmokingAreasMap } from "./SmokingAreasMap";
import type { SmokingAreaSearchParams } from "./features/smokingAreas/types"

export default function App() {
  const [ params, setParams ] = useState<SmokingAreaSearchParams>({});
  const [ selectedId, setSelectedId ] = useState<number | null>(null);

  const { state, refetch } = useSmokingAreas(params);

  useEffect(() => {
    if (selectedId === null) return;
    if (state.status !== "success") return;
    const found = state.data.find((data) => data.id === selectedId);
    if (!found) setSelectedId(null);
    // stateが変わったとき（タバコ種別フィルターでの変更時）のみ実行し、選択中のidをリセット
    // selectedIdの変化には反応不要のため依存配列から除外（ESLint導入時はdisableコメントを追加）
  }, [state]);

  return (
    <SmokingAreasMap
      state={state}
      selectedId={selectedId}
      setSelectedId={setSelectedId}
      params={params}
      setParams={setParams}
      refetchSmokingAreas={refetch}
    />
  );
}
