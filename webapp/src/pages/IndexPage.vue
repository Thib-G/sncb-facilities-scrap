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
        <sparql-query-component />
      </div>
    </div>
  </q-page>
</template>

<script setup>
import SparqlQueryComponent from 'components/SparqlQueryComponent.vue'
</script>
