import { fetchJson } from "../httpClient";
import { toSmokingAreaDisplay } from "./mapper";
import type { ApiSmokingAreaIndexItem } from "./types";
import type { SmokingAreaDisplay, SmokingAreaSearchParams } from "../../features/smokingAreas/types";
import type { QueryParams } from "../httpClient";


const buildSmokingAreasQuery = (params?: SmokingAreaSearchParams): QueryParams | undefined => {
    if (!params) return undefined;

    const { tobaccoTypeId, electronicOnly } = params;

    if (tobaccoTypeId === undefined && electronicOnly === undefined) return undefined;

    return {
        tobacco_type_id: tobaccoTypeId,
        electronic_only: electronicOnly ? "true" : undefined,
    };
};

export const fetchSmokingAreas = async (params?: SmokingAreaSearchParams): Promise<SmokingAreaDisplay[]> => {
    const query = buildSmokingAreasQuery(params);
    const apiItems = await fetchJson<ApiSmokingAreaIndexItem[]>("/v1/smoking_areas", { query });
    return apiItems.map(toSmokingAreaDisplay);
};
