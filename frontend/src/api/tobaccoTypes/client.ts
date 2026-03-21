import { fetchJson } from "../httpClient";
import { toTobaccoType } from "./mapper";
import type { ApiTobaccoType } from "./types";
import type { TobaccoType } from "../../features/smokingAreas/types";

export const fetchTobaccoTypes = async (): Promise<TobaccoType[]> => {
    const apiTobaccoTypes = await fetchJson<ApiTobaccoType[]>("/v1/tobacco_types");
    return apiTobaccoTypes.map(toTobaccoType);
};
