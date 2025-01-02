<template>
  <div>
    <h4>Yasgui</h4>
    <div class="yasgui-container" ref="yasgui"></div>
  </div>
</template>

<script setup>
import '@triply/yasgui/build/yasgui.min.css'

import Yasgui from '@triply/yasgui'
import { useTemplateRef, onMounted } from 'vue'

const yasguiRef = useTemplateRef('yasgui')

const query = `
PREFIX xyz: <http://sparql.xyz/facade-x/data/>
PREFIX fx: <http://sparql.xyz/facade-x/ns/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX ex: <http://example.org/>
PREFIX era: <http://data.europa.eu/949/>

CONSTRUCT {
  ?op a era:operationalPoint ;
       era:canonicalURI ?URI ;
       era:tafTAPCode ?tafTAPCode ;
       era:opName ?opName ;
       ex:name ?name ;
       ex:blue_bikes_presence ?blue_bikes_presence ;
       ex:cambio_information ?cambio_information ;
       ex:escalator ?escalator ;
       ex:free_toilets ?free_toilets ;
       ex:has_pmr_assistance ?has_pmr_assistance ;
       ex:lift_on_the_platform ?lift_on_the_platform ;
       ex:location_of_taxis ?location_of_taxis ;
       ex:luggage_lockers ?luggage_lockers ;
       ex:number_of_parking_places_for_pmr ?number_of_parking_places_for_pmr ;
       ex:other_shared_bikes_in_the_area ?other_shared_bikes_in_the_area ;
       ex:pmr_toilets ?pmr_toilets ;
       ex:paid_toilets ?paid_toilets ;
       ex:presence_of_connecting_buses ?presence_of_connecting_buses ;
       ex:presence_of_connecting_metro ?presence_of_connecting_metro ;
       ex:presence_of_connecting_tram ?presence_of_connecting_tram ;
       ex:presence_of_the_bikes_point ?presence_of_the_bikes_point ;
       ex:tvm_count ?tvm_count ;
       ex:wifi_presence ?wifi_presence .
}
WHERE {
  SERVICE <x-sparql-anything:> {
    fx:properties
      fx:location "https://linked-data.goelff.be/facilities.csv" ;
      fx:csv.headers "true" .
    ?row
      xyz:name ?name ;
      xyz:taftapcode ?tafTAPCode ;
      xyz:blue_bikes_presence ?blue_bikes_presence ;
      xyz:cambio_information ?cambio_information ;
      xyz:escalator ?escalator ;
      xyz:free_toilets ?free_toilets ;
      xyz:has_pmr_assistance ?has_pmr_assistance ;
      xyz:lift_on_the_platform ?lift_on_the_platform ;
      xyz:location_of_taxis ?location_of_taxis ;
      xyz:luggage_lockers ?luggage_lockers ;
      xyz:number_of_parking_places_for_pmr ?number_of_parking_places_for_pmr ;
      xyz:other_shared_bikes_in_the_area ?other_shared_bikes_in_the_area ;
      xyz:pmr_toilets ?pmr_toilets ;
      xyz:paid_toilets ?paid_toilets ;
      xyz:presence_of_connecting_buses ?presence_of_connecting_buses ;
      xyz:presence_of_connecting_metro ?presence_of_connecting_metro ;
      xyz:presence_of_connecting_tram ?presence_of_connecting_tram ;
      xyz:presence_of_the_bikes_point ?presence_of_the_bikes_point ;
      xyz:tvm_count ?tvm_count ;
      xyz:wifi_presence ?wifi_presence .
  }
  SERVICE <https://prod.virtuoso.ecdp.tech.ec.europa.eu/sparql> {
  	    ?op a era:OperationalPoint ;
            rdfs:label ?label ;
            era:opName ?opName ;
            era:tafTAPCode ?tafTAPCode ;
            era:uopid ?uniqueOpId ;
            era:canonicalURI ?URI ;
            era:inCountry <http://publications.europa.eu/resource/authority/country/BEL> .
        ?op era:opType ?opType .
        ?opType skos:prefLabel ?opTypeLabel .
        FILTER (lang(?opTypeLabel) = 'en')
  }
}
`

onMounted(() => {
  const yasgui = new Yasgui(yasguiRef.value, {
    requestConfig: { endpoint: 'https://linked-data.goelff.be/sparql.anything' },
  })
  const tab = yasgui.getTab()
  tab.setQuery(query)
  const yasqe = tab.yasqe
  yasqe.setSize(800, 500)
})
</script>

<style scoped></style>
