import type { SmokingAreaSearchParams } from "./features/smokingAreas/types";

type TobaccoTypeProps = {
  params: SmokingAreaSearchParams
  setParams: (params: SmokingAreaSearchParams) => void
};

const FILTER_OPTIONS = [
  {key: "paper", label: "紙タバコ", tobaccoTypeId: 1},
  {key: "electronic_only", label: "電子タバコのみ", electronicOnly: true}
] as const;

export const TobaccoTypeFilter = ({ params, setParams }: TobaccoTypeProps) => {

  return (
      <>
      {FILTER_OPTIONS.map((option) => {
          const isActive = option.key === "paper" ? params.tobaccoTypeId === option.tobaccoTypeId : params.electronicOnly === true;
          return <button type="button" key={option.key} 
            onClick={() => {
              if (isActive) {
                setParams({});
              } else if (option.key === "paper") {
                setParams({tobaccoTypeId: option.tobaccoTypeId});
              } else {
                setParams({electronicOnly: true});
              };
            }}
            aria-pressed={isActive} className={isActive ? "button button--active" : "button"}>
          {option.label}</button>
        })}
      </>
  );
};
