import { useEffect, useState } from "react";
import type { SmokingAreaDetail } from "../types";
import { fetchSmokingAreaDetail } from "../../../api/smokingAreas/client";
import { toError } from "./toError";

type UseSmokingAreaDetailResult = {
    data: SmokingAreaDetail | null;
    isLoading: boolean;
    error: Error | null;
    refetch: () => Promise<void>;
};

export const useSmokingAreaDetail = (id: number | null): UseSmokingAreaDetailResult => {
    const [data, setData] = useState<SmokingAreaDetail | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [error, setError] = useState<Error | null>(null);

    const refetch = async () => {
        if (id === null) {
            setData(null);
            setError(null);
            setIsLoading(false);
            return;
        };
        
        setIsLoading(true);
        setError(null);
        try {
            const smokingArea = await fetchSmokingAreaDetail(id);
            setData(smokingArea);
        } catch (e) {
            setError(toError(e));
        } finally {
            setIsLoading(false);
        };
    };

    useEffect(() => {
        refetch();
    }, [id]);

    return { data, isLoading, error, refetch };
};
