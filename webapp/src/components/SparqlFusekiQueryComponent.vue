<template>
  <div>
    <h4>Enrich data with federated query from local and ERA</h4>
    <yasgui-component :query="query" :endpoint="endpoint" persistence-id="fuseki-era-geo" />
  </div>
</template>

<script setup>
import YasguiComponent from 'components/YasguiComponent.vue';
import query from 'assets/queries/FacilitiesEraGeo.sparql';

const endpoint = 'https://fuseki.linked-data.goelff.be/sncb-facilities';
</script>
