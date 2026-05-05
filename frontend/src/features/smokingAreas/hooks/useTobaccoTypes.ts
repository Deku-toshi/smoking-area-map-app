import type { TobaccoType } from "../../../features/smokingAreas/types";
import { useState, useEffect } from "react";
import { fetchTobaccoTypes } from "../../../api/tobaccoTypes/client";

export const useTobaccoTypes = () => {
  const [data, setData] = useState<TobaccoType[]>([]);

  const refetch = () => {
    fetchTobaccoTypes()
      .then(setData)
      .catch(() => {});
  };

  useEffect(() => {
    refetch();
  }, []);

  return { data, refetch };
};
