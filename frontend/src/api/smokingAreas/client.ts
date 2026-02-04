import { fetchJson } from "../httpClient";
import { toSmokingAreaDisplay, toSmokingAreaDetail } from "./mapper";
import type { ApiSmokingAreaIndexItem, ApiSmokingAreaShow } from "./types";
import type { SmokingAreaDisplay, SmokingAreaDetail, SmokingAreaSearchParams } from "../../features/smokingAreas/types";
import type { QueryParams } from "../httpClient";


const buildSmokingAreasQuery = (params?: SmokingAreaSearchParams): QueryParams | undefined => {
    if (!params) return undefined;

    const { tobaccoTypeId, query } = params;

    if (tobaccoTypeId === undefined && query === undefined) return undefined;

    return {
        tobacco_type_id: tobaccoTypeId,
        query,
    };
};

export const fetchSmokingAreas = async (params?: SmokingAreaSearchParams): Promise<SmokingAreaDisplay[]> => {
    const query = buildSmokingAreasQuery(params);
    const apiItems = await fetchJson<ApiSmokingAreaIndexItem[]>("/v1/smoking_areas", { query });
    return apiItems.map(toSmokingAreaDisplay);
};

export const fetchSmokingAreaDetail = async (id: number): Promise<SmokingAreaDetail> => {
    const api = await fetchJson<ApiSmokingAreaShow>(`/v1/smoking_areas/${id}`);
    return toSmokingAreaDetail(api);
};
