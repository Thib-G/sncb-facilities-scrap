<template>
  <div>
    <h4>Transform CSV file to triples with IRI from ERA</h4>
    <yasgui-component :query="query" persistence-id="sparql-anything" />
  </div>
</template>

<script setup>
import YasguiComponent from 'components/YasguiComponent.vue'
import query from 'assets/queries/FacilitesCsvMergeWithEra.sparql'
</script>
