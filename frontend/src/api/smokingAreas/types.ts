export type ApiSmokingAreaIndexItem = {
    id: number;
    name: string;
    latitude: string;
    longitude: string;
    tobacco_type_ids: number[];
};

export type ApiSmokingAreaShowTobaccoType = {
    id: number;
    name: string;
    icon: string;
};

export type ApiSmokingAreaShow = {
    id: number;
    name: string;
    latitude: string;
    longitude: string;
    is_indoor: boolean | null;
    detail: string | null;
    address: string | null;
    tobacco_types: ApiSmokingAreaShowTobaccoType[];
};
