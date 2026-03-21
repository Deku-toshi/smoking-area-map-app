import type { ApiSmokingAreaIndexItem, ApiSmokingAreaShow } from "./types";
import type { SmokingAreaDisplay, SmokingAreaDetail } from "../../features/smokingAreas/types";

export const toSmokingAreaDisplay = (api: ApiSmokingAreaIndexItem): SmokingAreaDisplay => {
    return {
        id: api.id,
        name: api.name,
        latitude: Number(api.latitude),
        longitude: Number(api.longitude),
        tobaccoTypeIds: api.tobacco_type_ids
    };
};

export const toSmokingAreaDetail = (api: ApiSmokingAreaShow): SmokingAreaDetail => {
    return {
        id: api.id,
        name: api.name,
        latitude: Number(api.latitude),
        longitude: Number(api.longitude),
        isIndoor: api.is_indoor,
        detail: api.detail,
        address: api.address,
        tobaccoTypes: api.tobacco_types.map((tobacco_type) => ({
            id: tobacco_type.id,
            name: tobacco_type.name,
            icon: tobacco_type.icon
        })),
    };
};
