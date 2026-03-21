import { useState, useEffect } from "react";
import { useSmokingAreas } from "./features/smokingAreas/hooks/useSmokingAreas";
import { useSmokingAreaDetail } from "./features/smokingAreas/hooks/useSmokingAreaDetail";
import { useTobaccoTypes } from "./features/smokingAreas/hooks/useTobaccoTypes";
import { SmokingAreasMap } from "./SmokingAreasMap";
import type { SmokingAreaSearchParams } from "./features/smokingAreas/types"

export default function App() {
  const [ params, setParams ] = useState<SmokingAreaSearchParams>({});
  const [ selectedId, setSelectedId ] = useState<number | null>(null);

  const { data, isLoading, error, refetch } = useSmokingAreas(params);

  const { data: detail } = useSmokingAreaDetail(selectedId);
  const { data: tobaccoTypes } = useTobaccoTypes();

  useEffect(() => {
    if (selectedId === null) return;
    const found = data.find((area) => area.id === selectedId);
    if (!found) setSelectedId(null);
  }, [data]);

  return (
    <SmokingAreasMap
      smokingAreas={data}
      selectedId={selectedId}
      setSelectedId={setSelectedId}
      detail={detail}
      tobaccoTypes={tobaccoTypes ?? []}
      params={params}
      setParams={setParams}
      isLoading={isLoading}
      error={error}
      refetch={refetch}
    />
  );
}
