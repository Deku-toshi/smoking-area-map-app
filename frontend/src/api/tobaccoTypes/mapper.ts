import type { TobaccoType } from "../../features/smokingAreas/types";
import type { ApiTobaccoType } from "./types";

export const toTobaccoType = (api: ApiTobaccoType): TobaccoType => {
  return {
    id: api.id,
    name: api.name,
    icon: api.icon,
    displayOrder: api.display_order,
  };
};
