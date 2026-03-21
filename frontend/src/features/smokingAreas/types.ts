export type SmokingAreaDisplay = {
  id: number;
  name: string;
  latitude: number;
  longitude: number;
  tobaccoTypeIds: number[];
};

export type SmokingAreaDetailTobaccoType = {
  id: number;
  name: string;
  icon: string;
};

export type SmokingAreaDetail = {
  id: number;
  name: string;
  latitude: number;
  longitude: number;
  isIndoor: boolean | null;
  detail: string | null;
  address: string | null;
  tobaccoTypes: SmokingAreaDetailTobaccoType[];
};

export type SmokingAreaSearchParams = {
  tobaccoTypeId?: number;
  query?: string;electronicOnly?: boolean;
};

export type TobaccoType = {
  id: number;
  name: string;
  icon: string;
  displayOrder: number;
};
