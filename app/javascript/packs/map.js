let map = null;
let markers = [];
let infoWindow = null;

async function initMap() {
  // Google Maps API ライブラリのインポート
  // これにより、必要なライブラリが非同期でロードされ、ページの読み込みパフォーマンスが向上する
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
  const { LatLngBounds } = await google.maps.importLibrary("core");

  const mapElement = document.getElementById("map");

  // 地図要素が存在しない場合、既存の地図インスタンスとマーカーをすべてクリアして終了
  if (!mapElement) {
    console.error("地図の要素（id='map'）が存在しません。地図をクリアします。");
    clearMapAndMarkers();
    return;
  }

  // 地図要素が存在する場合でも、既存の地図、マーカー、InfoWindowをすべてクリアしてから再構築する
  // Turbo Driveによってページが再ロードされる際、地図が適切に再初期化されるようにするため
  clearMapAndMarkers();

  const lat = mapElement.dataset.latitude;
  const lng = mapElement.dataset.longitude;
  const isShowPage = mapElement.dataset.showPage === 'true';

  // 地図の初期化オプション
  let mapOptions = {
      mapId: "d204807a5becf3d0ccc4c959",
      mapTypeControl: false,
      fullscreenControl: false,
      streetViewControl: false
  };

  if (lat && lng) {
    // データ属性に緯度と経度がある場合(詳細ページ)
    const position = { lat: parseFloat(lat), lng: parseFloat(lng) };
    mapOptions.center = position;
    mapOptions.zoom = 15;

    map = new Map(mapElement, mapOptions);

    const marker = new AdvancedMarkerElement({
      position,
      map,
    });
    markers.push(marker);

  } else {
    // 緯度と経度がない場合(一覧ページ)
    let initialCenter = { lat: 35.681236, lng: 139.767125 };
    let initialZoom = 5;
    try {
      const response = await fetch("/lost_pets.json");
      if (!response.ok) throw new Error('Network response was not ok');

      const { data: { items } } = await response.json();
      if (!Array.isArray(items)) throw new Error("Items is not an array");

      if (items.length > 0) {
        const bounds = new LatLngBounds();
        infoWindow = new google.maps.InfoWindow(); // InfoWindowを初期化

        // マーカーを追加する前にMapインスタンスを生成する
        // これにより、AdvancedMarkerElementの'map'プロパティに設定できるようになる
        mapOptions.center = initialCenter;
        mapOptions.zoom = initialZoom;
        map = new Map(mapElement, mapOptions);

        items.forEach(item => {
          const lat = parseFloat(item.latitude);
          const lng = parseFloat(item.longitude);

          // 無効な緯度または経度のデータはスキップする
          if (isNaN(lat) || isNaN(lng)) return;

          const position = { lat, lng };
        
          const marker = new AdvancedMarkerElement({
            position,
            map,
          });
          markers.push(marker);
          
          bounds.extend(position);
          
          // InfoWindowの内容作成
          const genderJP = item.gender === 'male' ? 'オス' : item.gender === 'female' ? 'メス' : '不明';
          const animalTypeJP = item.animal_type || item.feature || '不明';
          const defaultImageUrl = mapElement.dataset.defaultImageUrl;
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
      
          marker.addListener("click", () => {
            infoWindow.setContent(content);
            infoWindow.open(map, marker);
          });
        });

        // 投稿が1件のみの場合、fitBoundsではズームレベルが適切でないため、個別に調整する
        if (bounds.getNorthEast().equals(bounds.getSouthWest())) {
          map.setZoom(10);
          map.setCenter(bounds.getCenter());
        } else {
          // 複数の投稿がある場合は、全てのマーカーが収まるように地図の表示範囲を調整する
          map.fitBounds(bounds);
        }

      } else {
        // 投稿が一つもない場合は、デフォルトの初期中心とズームで地図を表示
        mapOptions.center = initialCenter;
        mapOptions.zoom = initialZoom;
        map = new Map(mapElement, mapOptions);
      }
      
    } catch (error) {
      console.error('Error fetching or processing lost pets:', error);

       // エラー発生時でも、地図がまだ初期化されていない場合は、デフォルトの地図を表示する
      if (!map) {
        mapOptions.center = initialCenter;
        mapOptions.zoom = initialZoom;
        map = new Map(mapElement, mapOptions);
      }
    }
  }
}

// 地図、マーカー、InfoWindowをクリアするための共通関数
function clearMapAndMarkers() {
  markers.forEach(marker => {
    // マーカーが地図上に存在する場合、地図から削除する
    if (marker && marker.map) {
      marker.map = null;
    }
  });
  markers = []; // マーカー配列を空にする

  if (infoWindow) {
      infoWindow.close();
      infoWindow = null;
  }

  // mapインスタンスをnullにすることで、次のinitMapで新しいMapインスタンスが確実に生成されるようにする
  map = null;
}

window.initMap = initMap;

// Turbo Drive のイベントリスナーを設定する
// ページのロード時、またはTurbo Driveによるナビゲーション時に地図を適切に初期化する
document.addEventListener("turbo:load", () => {
  const mapElement = document.getElementById("map");
  if (mapElement) {
    initMap();
  } else {
    // 地図要素が存在しないページに遷移した場合、既存の地図とマーカーをすべてクリアする
    clearMapAndMarkers();
  }
});