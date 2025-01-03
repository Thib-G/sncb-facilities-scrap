<template>
  <div>
    <h4>Leaflet Map</h4>
    <pre><code>{{ query }}</code></pre>
    <div ref="map" class="leaflet-map"></div>
  </div>
</template>

<script setup>
import 'leaflet/dist/leaflet.css'
import L from 'leaflet'
import parseWKT from 'wellknown'
import { useTemplateRef, onMounted, ref, shallowRef, computed, watch } from 'vue'
import { mapBoxKey } from 'assets/keys'

import query from 'assets/queries/FacilitiesEraGeo.sparql'

const endpoint = 'https://fuseki.linked-data.goelff.be/sncb-facilities'

const mapRef = useTemplateRef('map')

const map = ref()
const lgResult = shallowRef(L.layerGroup())

const json = shallowRef({ head: { vars: [] }, results: { bindings: [] } })
const geojson = computed(() => ({
  type: 'FeatureCollection',
  features: json.value.results.bindings.map((item) => ({
    type: 'Feature',
    properties: item,
    geometry: parseWKT(item.geometryWKT.value),
  })),
}))

watch(geojson, (newGeojson) => {
  lgResult.value.clearLayers()
  const newLayers = L.geoJson(newGeojson, {
    pointToLayer: (feature, latlng) =>
      L.circleMarker(latlng, {
        radius: 4,
        weight: 2,
        opacity: 0.7,
      }),
    onEachFeature: (feature, layer) => {
      const p = feature.properties
      const popupContent = Object.keys(p).map((k) => `<b>${k}:</b> ${p[k].value}`)
      layer.bindPopup(popupContent.join('<br>'))
    },
  })
  lgResult.value.addLayer(newLayers)
})

const options = { tileSize: 512, maxZoom: 18, zoomOffset: -1 }
const basemaps = {
  dark: L.tileLayer(
    `https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/{z}/{x}/{y}@2x?access_token=${mapBoxKey}`,
    {
      attribution: `&copy; <a href="https://www.mapbox.com/feedback/">Mapbox</a>
                        &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>`,
      ...options,
    },
  ),
  light: L.tileLayer(
    `https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/{z}/{x}/{y}@2x?access_token=${mapBoxKey}`,
    {
      attribution: `&copy; <a href="https://www.mapbox.com/feedback/">Mapbox</a>
                        &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>`,
      ...options,
    },
  ),
  satellite: L.tileLayer(
    `https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v11/tiles/{z}/{x}/{y}@2x?access_token=${mapBoxKey}`,
    {
      attribution: `&copy; <a href="https://www.mapbox.com/feedback/">Mapbox</a>
                        &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>`,
      ...options,
    },
  ),
}

onMounted(async () => {
  map.value = L.map(mapRef.value, {
    center: [50 + 38 / 60 + 28 / 3600, 4 + 40 / 60 + 5 / 3600],
    zoom: 8,
  })
  basemaps.light.addTo(map.value)
  L.control
    .layers(basemaps, {
      Results: lgResult.value,
    })
    .addTo(map.value)

  lgResult.value.addTo(map.value)

  const response = await fetch(endpoint, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/sparql-query',
      Accept: 'application/json',
    },
    body: query,
  })

  json.value = await response.json()
})
</script>

<style scoped>
.leaflet-map {
  min-width: 400px;
  min-height: 400px;
}
</style>
