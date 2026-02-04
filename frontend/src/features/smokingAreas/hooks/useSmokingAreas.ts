import type { SmokingAreaDisplay, SmokingAreaSearchParams } from "../types";
import { fetchSmokingAreas } from "../../../api/smokingAreas/client";
import { useEffect, useState } from "react";
import { toError } from "./toError";

type UseSmokingAreasResult = {
    data: SmokingAreaDisplay[];
    isLoading: boolean;
    error: Error | null;
    refetch: () => Promise<void>;
};

export const useSmokingAreas = (params?: SmokingAreaSearchParams): UseSmokingAreasResult => {
    const [data, setData] = useState<SmokingAreaDisplay[]>([]);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<Error | null>(null);

    const refetch = async () => {
        setIsLoading(true);
        setError(null);
        try {
            const smokingAreas = await fetchSmokingAreas(params);
            setData(smokingAreas);
        } catch (e) {
            setError(toError(e));
        } finally {
            setIsLoading(false);
        };
    };

    useEffect(() => {
        refetch();
    }, [params?.tobaccoTypeId, params?.query]);

    return { data, isLoading, error, refetch };
};
