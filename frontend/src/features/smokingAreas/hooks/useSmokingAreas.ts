import type { SmokingAreaDisplay, SmokingAreaSearchParams } from "../types";
import type { FetchState } from "../../../types/fetchState";
import { fetchSmokingAreas } from "../../../api/smokingAreas/client";
import { useEffect, useState } from "react";
import { toError } from "./toError";

type UseSmokingAreasResult = {
  state: FetchState<SmokingAreaDisplay[]>;
  refetch: () => Promise<void>;
};

export const useSmokingAreas = (params?: SmokingAreaSearchParams): UseSmokingAreasResult => {
  const [state, setState] = useState<FetchState<SmokingAreaDisplay[]>>({ status: "loading" });

  const refetch = async () => {
    setState({ status: "loading" });
    try {
      const smokingAreas = await fetchSmokingAreas(params);
      setState({ status: "success", data: smokingAreas });
    } catch (e) {
      setState({ status: "error", error: toError(e) });
    }
  };

  useEffect(() => {
    refetch();
  }, [params?.tobaccoTypeId, params?.electronicOnly]);

  return { state, refetch };
};
