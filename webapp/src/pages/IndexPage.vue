<template>
  <q-page class="q-ma-lg">
    <div class="row">
      <div class="col">
        <h2>Linked Data UGent Project</h2>
      </div>
    </div>
    <q-separator />
    <div class="row">
      <div class="col">
        <h3>Context</h3>
        <p>First I started by making a poster as required.</p>
        <div>
          <a href="images/poster.pdf" target="_blank" alt="Click to open poster"
            ><q-img src="images/poster.jpg" alt="Poster" class="q-mt-md" style="max-width: 400px" />
          </a>
        </div>
        <p>Then I had to do something to implement what I proposed.</p>
      </div>
    </div>
    <div class="row">
      <div class="col">
        <h3>1) Scrape the data from NMBS website.</h3>
        <p>
          Fortunately, this part was made last year in a Jupyter notebook. The data was scraped from
          the NMBS website.<br />
          Recently, it sadly became impossible to scrape it easily anymore because of Cloudflare's
          captchas.
          <br />The notebooks used to extract the data are here:
        </p>

        <ul>
          <li>
            <a
              href="https://github.com/Thib-G/sncb-facilities-scrap/blob/main/1_scrape-sncb-stations-urls.ipynb"
              target="_blank"
              >1_scrape-sncb-stations-urls.ipynb</a
            >: Extract the table of content of all stations.
          </li>
          <li>
            <a
              href="https://github.com/Thib-G/sncb-facilities-scrap/blob/main/2_sncb-scrape-all-stations.ipynb"
              target="_blank"
              >2_sncb-scrape-all-stations.ipynb</a
            >: Browse all stations and extract the data from the DOM.
          </li>
          <li>
            <a
              href="https://github.com/Thib-G/sncb-facilities-scrap/blob/main/3_flatten-facilities.ipynb"
              target="_blank"
              >3_flatten-facilities.ipynb</a
            >: Create a large CSV file with all the collected data.
          </li>
          <li>
            <a
              href="https://github.com/Thib-G/sncb-facilities-scrap/blob/main/4_combine_with_data.ipynb"
              target="_blank"
              >4_combine_with_data.ipynb</a
            >: Combine the data with ERA data based on the station name.
          </li>
        </ul>
      </div>
    </div>
    <q-separator />
    <div class="row">
      <div class="col">
        <h3>2) Sparql Anything query</h3>
        <p>
          Then I used <a href="https://sparql-anything.cc/" target="_blank">Sparql Anything</a> to
          convert the CSV data to Linked Data.
        </p>
        <p>
          This query generates triples from the CSV file from above, using Sparql Anything. You can
          run it here, but it is quite slow (about 80s which is higher that the one minute given to
          present the project!)
        </p>
        <YasguiComponent :query="csvQuery" persistence-id="sparql-anything" />
        <p class="q-mt-lg">The result is made available in Apache Jena here:</p>
        <ul>
          <li>
            Info:
            <a
              href="https://fuseki.linked-data.goelff.be/#/dataset/sncb-facilities/info"
              target="_blank"
              >https://fuseki.linked-data.goelff.be/#/dataset/sncb-facilities/info</a
            >
          </li>
          <li>Sparql Endpoint: <b>https://fuseki.linked-data.goelff.be/sncb-facilities/</b></li>
          <li>
            Download data:
            <a href="https://fuseki.linked-data.goelff.be/sncb-facilities/data" target="_blank"
              >https://fuseki.linked-data.goelff.be/sncb-facilities/data</a
            >
          </li>
        </ul>
      </div>
    </div>
    <div class="row">
      <div class="col">
        <h3>3) Combine with (geo) data from ERA</h3>
        <p>
          This query combines data from the output of the Sparql-Anything query with geo data from
          ERA, and shows it on a map using the brand new
          <a href="https://github.com/Thib-G/yasgui-geo-tg" target="_blank">Yasgui geo plugin</a>,
          tailor-made for this project and freely reusable by anyone!
        </p>
        <p>
          The query is dynamic and can be changed to show different fields. The default is the
          presence of PMR assistance and lift on the platform. Don't forget to click the
          <q-icon name="play_arrow" size="1.4em" /> Run query button.
        </p>
        <div class="row q-mb-md">
          <div class="col-12 col-sm-6 col-md-4" v-for="(field, index) in fields" :key="index">
            <q-checkbox
              v-model="selectedFields"
              :val="field"
              :label="field.description"
              class="q-mb-sm inline"
            />
          </div>
        </div>
        <YasguiComponent
          :query="currentEraQuery"
          persistence-id="fuseki-era-geo"
          endpoint="https://fuseki.linked-data.goelff.be/sncb-facilities"
        />
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';

import YasguiComponent from 'src/components/YasguiComponent.vue';

import csvQuery from 'src/assets/queries/FacilitesCsvMergeWithEra.sparql';
import eraQuery from 'src/assets/queries/FacilitiesEraGeoDynamic.js';

const fields = [
  { field: 'blue_bikes_presence', description: 'Blue Bikes Presence' },
  { field: 'cambio_information', description: 'Cambio Information' },
  { field: 'escalator', description: 'Escalator' },
  { field: 'free_toilets', description: 'Free Toilets' },
  { field: 'has_pmr_assistance', description: 'Has Pmr Assistance' },
  { field: 'lift_on_the_platform', description: 'Lift On The Platform' },
  { field: 'location_of_taxis', description: 'Location Of Taxis' },
  { field: 'luggage_lockers', description: 'Luggage Lockers' },
  { field: 'number_of_parking_places_for_pmr', description: 'Number Of Parking Places For Pmr' },
  { field: 'other_shared_bikes_in_the_area', description: 'Other Shared Bikes In The Area' },
  { field: 'pmr_toilets', description: 'Pmr Toilets' },
  { field: 'paid_toilets', description: 'Paid Toilets' },
  { field: 'presence_of_connecting_buses', description: 'Presence Of Connecting Buses' },
  { field: 'presence_of_connecting_metro', description: 'Presence Of Connecting Metro' },
  { field: 'presence_of_connecting_tram', description: 'Presence Of Connecting Tram' },
  { field: 'presence_of_the_bikes_point', description: 'Presence Of The Bikes Point' },
  { field: 'tvm_count', description: 'Tvm Count' },
  { field: 'wifi_presence', description: 'Wifi Presence' },
];

const selectedFields = ref([fields[4], fields[5]]);

const currentEraQuery = computed(() => eraQuery(selectedFields.value.map((item) => item.field)));
onMounted(() => {
  setTimeout(() => {
    window.scrollTo(0, 0);
  }, 100);
});
</script>
