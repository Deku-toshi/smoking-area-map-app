import {  APIProvider, Map, AdvancedMarker, InfoWindow, useAdvancedMarkerRef, MapControl, ControlPosition } from "@vis.gl/react-google-maps";
import { TobaccoTypeFilter }  from "./TobaccoTypeFilter"
import type { SmokingAreaDisplay, SmokingAreaDetail, TobaccoType, SmokingAreaSearchParams } from "./features/smokingAreas/types";

type SmokingAreasMapProps = { 
  smokingAreas: SmokingAreaDisplay[];
  isLoading: boolean;
  error: Error | null;
  selectedId: number | null;
  setSelectedId: (id: number | null) => void;
  detail: SmokingAreaDetail | null;
  tobaccoTypes: TobaccoType[];
  params: SmokingAreaSearchParams
  setParams: (params: SmokingAreaSearchParams) => void;
  refetch: () => Promise<void>;
};

export const SmokingAreasMap = ({ smokingAreas, selectedId, setSelectedId, detail, tobaccoTypes, params, setParams, isLoading, error, refetch }: SmokingAreasMapProps) => {
  const apiKey = import.meta.env.VITE_GOOGLE_MAPS_API_KEY;
  const mapId = import.meta.env.VITE_GOOGLE_MAPS_MAP_ID;

  const [markerRef, marker] = useAdvancedMarkerRef();
  const selectedSmokingArea = selectedId === null ? null : smokingAreas.find((smokingArea) => smokingArea.id === selectedId) ?? null;
  const selectedDetail = selectedId !== null && detail?.id === selectedId ? detail : null;

  const selectedTobaccoTypeIds = selectedSmokingArea?.tobaccoTypeIds ?? []
  const selectedTobaccoTypes = tobaccoTypes.filter((tobaccoType) => selectedTobaccoTypeIds.includes(tobaccoType.id))
                               .sort((a, b) => a.displayOrder - b.displayOrder)
                               .map((tobaccoType) => tobaccoType.name)
                               .join(", ");

  const center = { lat: 35.690921, lng: 139.700258 };

  return (
    <div className="map-container">
      {isLoading && <div className="loading-overlay">Loading...</div>}
      {error && 
        <div className="error-overlay">
          <p>データの取得に失敗しました</p>
          <button onClick={refetch}>再取得</button>
        </div>}
      <APIProvider apiKey={apiKey} libraries={['marker']}>
        <Map defaultCenter={center} defaultZoom={16} mapId={mapId} fullscreenControl={true}
        disableDefaultUI={true} zoomControl={true} clickableIcons={false} keyboardShortcuts={false}>
        {selectedSmokingArea && marker && (
          <InfoWindow anchor={marker} onCloseClick={() => setSelectedId(null)}>
            <div><strong>{selectedSmokingArea.name}</strong></div>
            <div>対応：{selectedTobaccoTypes}</div>
            <div>詳細：{selectedDetail?.detail}</div>
          </InfoWindow>
        )}
          <MapControl position={ControlPosition.TOP_LEFT}>
            <TobaccoTypeFilter params={params} setParams={setParams} />
          </MapControl>
          {smokingAreas.map((smokingArea) => {
            const isSelected = selectedId === smokingArea.id;
            return <AdvancedMarker 
            key={smokingArea.id} 
            position={{ lat: smokingArea.latitude, lng: smokingArea.longitude}}
            onClick={() => setSelectedId(isSelected ? null : smokingArea.id)} 
            ref={isSelected ? markerRef : undefined}>
              <div className={isSelected ? "marker-dot marker-dot--selected" : "marker-dot"}></div>
            </AdvancedMarker>
          })}
        </Map>
      </APIProvider>
    </div>
  )
};
