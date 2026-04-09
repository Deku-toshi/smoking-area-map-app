export type SmokingAreaDisplay = {
  id: number;
  name: string;
  latitude: number;
  longitude: number;
  tobaccoTypeIds: number[];
};

export type SmokingAreaSearchParams = {
  tobaccoTypeId?: number;
  query?: string;
  electronicOnly?: boolean;
};

export type TobaccoType = {
  id: number;
  name: string;
  icon: string;
  displayOrder: number;
};
