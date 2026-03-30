import {  APIProvider, Map, AdvancedMarker, MapControl, ControlPosition, useMap } from "@vis.gl/react-google-maps";
import { TobaccoTypeFilter }  from "./TobaccoTypeFilter"
import type { SmokingAreaDisplay, TobaccoType, SmokingAreaSearchParams } from "./features/smokingAreas/types";
import { useEffect, useState } from "react";
import { LocateFixed } from "lucide-react";

type SmokingAreasMapProps = { 
  smokingAreas: SmokingAreaDisplay[];
  isLoading: boolean;
  error: Error | null;
  selectedId: number | null;
  setSelectedId: (id: number | null) => void;
  tobaccoTypes: TobaccoType[];
  params: SmokingAreaSearchParams
  setParams: (params: SmokingAreaSearchParams) => void;
  refetch: () => Promise<void>;
};

const CurrentLocationHandler = ({ position }: { position: { lat: number, lng: number } | null }) => {
  const map = useMap();

  useEffect(() => {
    if (map && position) {
      map.panTo(position);
    }
  }, [map, position]);

  return (
    <MapControl position={ControlPosition.RIGHT_BOTTOM}>
      <button className="current-location-button" onClick={() => { if (map && position) map.panTo(position); }}>
        <LocateFixed size={20} color="currentColor" />
      </button>
    </MapControl>
  );
};

export const SmokingAreasMap = ({ smokingAreas, selectedId, setSelectedId, tobaccoTypes, params, setParams, isLoading, error, refetch }: SmokingAreasMapProps) => {
  const apiKey = import.meta.env.VITE_GOOGLE_MAPS_API_KEY;
  const mapId = import.meta.env.VITE_GOOGLE_MAPS_MAP_ID;

  const [position, setPosition] = useState<{lat: number, lng: number} | null>(null);

  useEffect(() => {
    navigator.geolocation.getCurrentPosition((position) => {
      setPosition({lat: position.coords.latitude, lng: position.coords.longitude});
    });
  }, []);

  const selectedSmokingArea = selectedId === null ? null : smokingAreas.find((smokingArea) => smokingArea.id === selectedId) ?? null;

  const selectedTobaccoTypeIds = selectedSmokingArea?.tobaccoTypeIds ?? []
  const selectedTobaccoTypes = tobaccoTypes.filter((tobaccoType) => selectedTobaccoTypeIds.includes(tobaccoType.id))
                               .sort((a, b) => a.displayOrder - b.displayOrder)
                               .map((tobaccoType) => tobaccoType.name)
                               .join(", ");

  const defaultCenter = { lat: 35.6812, lng: 139.7671 };

  return (
    <div className="map-container">
      {isLoading && <div className="loading-overlay">Loading...</div>}
      {error && 
        <div className="error-overlay">
          <p>データの取得に失敗しました</p>
          <button onClick={refetch}>再取得</button>
        </div>}
      <APIProvider apiKey={apiKey} libraries={['marker']}>
        <Map defaultCenter={defaultCenter} defaultZoom={17} mapId={mapId} 
        fullscreenControl={true}disableDefaultUI={true} zoomControl={true} clickableIcons={false} 
        keyboardShortcuts={false} draggableCursor="default" draggingCursor="move" onClick={() => setSelectedId(null)}>
          <CurrentLocationHandler position={position} />
          <MapControl position={ControlPosition.TOP_LEFT}>
            <TobaccoTypeFilter params={params} setParams={setParams} />
          </MapControl>
          {position && <AdvancedMarker position={position} />}
          {smokingAreas.map((smokingArea) => {
            const isSelected = selectedId === smokingArea.id;
            return <AdvancedMarker 
            key={smokingArea.id} 
            position={{ lat: smokingArea.latitude, lng: smokingArea.longitude}}
            onClick={() => setSelectedId(isSelected ? null : smokingArea.id)}>
              <div className="marker-wrapper">
                <div className={isSelected ? "marker-dot marker-dot--selected" : "marker-dot"}/>
                {isSelected && (
                  <div className="marker-popup" onClick={(e) => e.stopPropagation()}>
                    <button className="marker-popup-close" onClick={(e) => { e.stopPropagation(); setSelectedId(null); }}>×</button>
                    <div className="marker-popup-name"><strong>{smokingArea.name}</strong></div>
                    <div>対応：{selectedTobaccoTypes}</div>
                  </div>)}
              </div>
            </AdvancedMarker>
          })}
        </Map>
      </APIProvider>
    </div>
  )
};
