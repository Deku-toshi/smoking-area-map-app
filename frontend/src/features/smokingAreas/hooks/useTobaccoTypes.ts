import type { TobaccoType } from "../../../features/smokingAreas/types";
import { useState, useEffect } from "react";
import { fetchTobaccoTypes } from "../../../api/tobaccoTypes/client";
import { toError } from "./toError";

type UseTobaccoTypesResult = {
  data: TobaccoType[];
  isLoading: boolean;
  error: Error | null;
  refetch: () => Promise<void>;
};

export const useTobaccoTypes = (): UseTobaccoTypesResult => {
    const [data, setData] = useState<TobaccoType[]>([]);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<Error | null>(null);

    const refetch = async () => {
        setIsLoading(true);
        setError(null);
        try {
            const tobaccoTypes = await fetchTobaccoTypes();
            setData(tobaccoTypes);
        } catch (e) {
            setError(toError(e));
        } finally {
            setIsLoading(false);
        }
    };

    useEffect(() => {
        refetch();
    }, [])

    return { data, isLoading, error, refetch };
};
