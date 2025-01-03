<template>
  <q-page class="q-ma-lg">
    <div class="row">
      <div class="column">
        <h2>SparQL Query</h2>
      </div>
    </div>
    <q-separator />
    <div class="row">
      <div class="column">
        <h3>SparQL-Anything query</h3>
        <p>This is a SparQL Query</p>
        <sparql-anything-query-component />
      </div>
    </div>
    <div class="row">
      <div class="column">
        <h3>Combine with (geo) data from ERA</h3>
        <p>This is a SparQL Query</p>
        <sparql-fuseki-query-component />
      </div>
    </div>
    <div class="row">
      <div class="column">
        <h3>Map</h3>
        <p>This is a SparQL Query</p>
        <sparql-fuseki-map-component />
      </div>
    </div>
  </q-page>
</template>

<script setup>
import SparqlAnythingQueryComponent from 'src/components/SparqlAnythingQueryComponent.vue'
import SparqlFusekiQueryComponent from 'src/components/SparqlFusekiQueryComponent.vue'
import SparqlFusekiMapComponent from 'components/SparqlFusekiMapComponent.vue'
</script>
