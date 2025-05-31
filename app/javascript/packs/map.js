let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

  const mapElement = document.getElementById("map");

  const lat = mapElement.dataset.latitude;
  const lng = mapElement.dataset.longitude;

  if (lat && lng) {
 
    const position = { lat: parseFloat(lat), lng: parseFloat(lng) };

    map = new Map(mapElement, {
      center: position,
      zoom: 15,
      mapId: "DEMO_MAP_ID",
      mapTypeControl: false
    });

    new AdvancedMarkerElement({
      position,
      map,
    });

  } else {

    let initialCenter = { lat: 35.681236, lng: 139.767125 };

    try {
      const response = await fetch("/lost_pets.json");
      if (!response.ok) throw new Error('Network response was not ok');

      const { data: { items } } = await response.json();
      if (!Array.isArray(items)) throw new Error("Items is not an array");

      if (items.length > 0) {
        initialCenter = { lat: items[0].latitude, lng: items[0].longitude };
      }

      map = new Map(mapElement, {
        center: initialCenter,
        zoom: 15,
        mapId: "DEMO_MAP_ID",
        mapTypeControl: false
      });

      const bounds = new google.maps.LatLngBounds();

      items.forEach(item => {
        const position = { lat: item.latitude, lng: item.longitude };
      
        const marker = new AdvancedMarkerElement({
          position,
          map,
        });
      
        const genderJP = item.gender === 'male' ? 'オス' :
        item.gender === 'female' ? 'メス' : '不明';

        const animalTypeJP = item.animal_type || item.feature || '不明';

        const defaultImageUrl = document.getElementById('map').dataset.defaultImageUrl;
        const postImage = item.image_url && item.image_url.trim() !== "" ? item.image_url : defaultImageUrl;

        const content = `
        <div style="font-family: Arial, sans-serif; max-width: 250px;">
          <div style="font-weight:bold; font-size:16px; margin-bottom:6px;">
            ${item.title}
          </div>
          <img src="${postImage}" style="width:100%; border-radius:8px; object-fit:cover; margin-bottom:6px;">
          <div style="font-size:14px; margin-bottom:4px;">名前: ${item.name || '不明'}</div>
          <div style="font-size:14px; margin-bottom:4px;">種類: ${item.animal_type || '不明'}</div>
          <div style="font-size:12px; color: #555; margin-bottom:8px;">
            最終目撃場所: ${item.last_seen_location || '不明'}
          </div>
          <div style="font-size:13px; text-align:right;">
            <a href="/lost_pets/${item.id}" style="color:#1a73e8; text-decoration:underline;">
              ▶ 詳細を見る
            </a>
          </div>
        </div>
      `;

        const infoWindow = new google.maps.InfoWindow({
          content,
        });
    
        marker.addListener("click", () => {
          infoWindow.open(map, marker);
        });
      
        bounds.extend(position);
      });
      
      map.fitBounds(bounds);

    } catch (error) {
      console.error('Error fetching or processing lost pets:', error);

      if (!map) {
        map = new Map(mapElement, {
          center: initialCenter,
          zoom: 15,
          mapId: "DEMO_MAP_ID",
          mapTypeControl: false
        });
      }
    }
  }
}

window.initMap = initMap;

document.addEventListener("turbo:load", () => {
  const mapElement = document.getElementById("map");
  if (mapElement) {
    initMap();
  }
});