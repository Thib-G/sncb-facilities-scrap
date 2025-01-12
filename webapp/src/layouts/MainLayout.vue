<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <q-btn flat dense round icon="menu" aria-label="Menu" @click="toggleLeftDrawer" />

        <q-toolbar-title> Linked Data Project </q-toolbar-title>

        <div>Quasar v{{ $q.version }}</div>
      </q-toolbar>
    </q-header>

    <q-drawer v-model="leftDrawerOpen" show-if-above bordered>
      <q-list>
        <q-item-label header> Essential Links </q-item-label>

        <EssentialLink v-for="link in linksList" :key="link.title" v-bind="link" />
      </q-list>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { ref } from 'vue';
import EssentialLink from 'components/EssentialLink.vue';

const linksList = [
  {
    title: 'Source CSV',
    caption: 'linked-data.goelff.be/facilities.csv',
    icon: 'description',
    link: 'https://linked-data.goelff.be/facilities.csv',
  },
  {
    title: 'Code for this project',
    caption: 'github.com/Thib-G/sncb-facilities-scrap',
    icon: 'code',
    link: 'https://github.com/Thib-G/sncb-facilities-scrap',
  },
  {
    title: 'Yasgui geo plugin',
    caption: 'github.com/Thib-G/yasgui-geo-tg',
    icon: 'public',
    link: 'https://github.com/Thib-G/yasgui-geo-tg',
  },
  {
    title: 'Fuseki',
    caption: 'fuseki.linked-data.goelff.be',
    icon: 'storefront',
    link: 'https://fuseki.linked-data.goelff.be',
  },
  {
    title: 'Yasgui geo endpoint',
    caption: 'linked-data.goelff.be/yasgui/',
    icon: 'dns',
    link: `https://linked-data.goelff.be/yasgui/#query=PREFIX%20gsp%3A%20%3Chttp%3A%2F%2Fwww.opengis.net%2Font%2Fgeosparql%23%3E%0APREFIX%20rdf%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0APREFIX%20xsd%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23%3E%0APREFIX%20xyz%3A%20%3Chttp%3A%2F%2Fsparql.xyz%2Ffacade-x%2Fdata%2F%3E%0APREFIX%20fx%3A%20%3Chttp%3A%2F%2Fsparql.xyz%2Ffacade-x%2Fns%2F%3E%0A%0ASELECT%20*%20WHERE%20%0A%7B%0A%20%20FILTER%20(%3Fshort_name_iso2%20!%3D%20'RU')%0A%20%20%7B%20%20%20%20%0A%20%20%20%20SELECT%20%3Fname%20%3Fshort_name_fips%20%3Fshort_name_iso2%20%3Fshort_name_iso3%20(STRDT(CONCAT(%22POLYGON(%22%2CGROUP_CONCAT(CONCAT(%3Fcoordinate_string)%3B%20SEPARATOR%3D%22%2C%20%22)%2C%22)%22)%2C%20gsp%3AwktLiteral)%20AS%20%3Fwkt)%0A%20%20%20%20WHERE%20%7B%0A%20%20%20%20%20%20SELECT%20%3Fname%20%3Fshort_name_fips%20%3Fshort_name_iso2%20%3Fshort_name_iso3%20%3Fpolygon_index%20(CONCAT(%22(%22%2CGROUP_CONCAT(CONCAT(%3Fwkt_coordinate)%3B%20SEPARATOR%3D%22%2C%20%22)%2C%22)%22)%20AS%20%3Fcoordinate_string)%0A%20%20%20%20%20%20WHERE%20%7B%0A%20%20%20%20%20%20%20%20SERVICE%20%3Cx-sparql-anything%3Alocation%3A%3E%20%7B%0A%20%20%20%20%20%20%20%20%20%20fx%3Aproperties%20fx%3Alocation%20%22https%3A%2F%2Fraw.githubusercontent.com%2FleakyMirror%2Fmap-of-europe%2Frefs%2Fheads%2Fmaster%2FGeoJSON%2Feurope.geojson%22%20%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20fx%3Amedia-type%20%20%22application%2Fjson%22%20.%09%0A%20%20%20%20%20%20%20%20%20%20%3Fs%20xyz%3Atype%20%22Feature%22%3B%0A%20%20%20%20%20%20%20%20%20%20xyz%3Ageometry%20%3Fgeom%3B%0A%20%20%20%20%20%20%20%20%20%20xyz%3Aproperties%20%3Fprops.%0A%0A%20%20%20%20%20%20%20%20%20%20%3Fprops%20xyz%3ANAME%20%3Fname%3B%0A%20%20%20%20%20%20%20%20%20%20xyz%3AFIPS%20%3Fshort_name_fips%3B%0A%20%20%20%20%20%20%20%20%20%20xyz%3AISO2%20%3Fshort_name_iso2%3B%0A%20%20%20%20%20%20%20%20%20%20xyz%3AISO3%20%3Fshort_name_iso3.%0A%0A%20%20%20%20%20%20%20%20%20%20%3Fgeom%20xyz%3Atype%20%3Fwkt_type%3B%0A%20%20%20%20%20%20%20%20%20%20xyz%3Acoordinates%20%3Fmulti_polygon.%0A%0A%20%20%20%20%20%20%20%20%20%20%3Fmulti_polygon%20%3Flist_polygon_element%20%3Fpolygon%20.%0A%20%20%20%20%20%20%20%20%20%20BIND%20(xsd%3Ainteger(replace(STR(%3Flist_polygon_element)%2C'http%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23_'%2C''))%20AS%20%3Fpolygon_index)%0A%0A%20%20%20%20%20%20%20%20%20%20%3Fpolygon%20%3Flist_coordinate_element%20%3Fcoordinate%20.%0A%20%20%20%20%20%20%20%20%20%20BIND%20(xsd%3Ainteger(replace(STR(%3Flist_coordinate_element)%2C'http%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23_'%2C''))%20AS%20%3Fcoordinate_index)%0A%0A%20%20%20%20%20%20%20%20%20%20%3Fcoordinate%20rdf%3A_1%20%3Flongitude%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20rdf%3A_2%20%3Flatitude.%0A%0A%20%20%20%20%20%20%20%20%20%20BIND%20(CONCAT(str(%3Flongitude)%2C%20%22%20%22%2C%20str(%3Flatitude))%20AS%20%3Fwkt_coordinate)%20%20%0A%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20FILTER%20(str(%3Fwkt_type)%20%3D%20%22Polygon%22)%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20GROUP%20BY%20%3Fname%20%3Fshort_name_fips%20%3Fshort_name_iso2%20%3Fshort_name_iso3%20%3Fpolygon_index%0A%20%20%20%20%20%20ORDER%20BY%20%3Fcoordinate_index%20%0A%20%20%20%20%7D%0A%20%20%20%20GROUP%20BY%20%3Fname%20%3Fshort_name_fips%20%3Fshort_name_iso2%20%3Fshort_name_iso3%0A%20%20%20%20ORDER%20BY%20%3Fpolygon_index%20%0A%20%20%7D%0A%20%20UNION%0A%20%20%7B%0A%20%20%20%20SELECT%20%3Fname%20%3Fshort_name_fips%20%3Fshort_name_iso2%20%3Fshort_name_iso3%20(STRDT(CONCAT(%22MULTIPOLYGON(%22%2CGROUP_CONCAT(CONCAT(%3Fpolygon_string)%3B%20SEPARATOR%3D%22%2C%20%22)%2C%22)%22)%2C%20gsp%3AwktLiteral)%20AS%20%3Fwkt)%0A%20%20%20%20WHERE%20%7B%0A%20%20%20%20%20%20SELECT%20%3Fname%20%3Fshort_name_fips%20%3Fshort_name_iso2%20%3Fshort_name_iso3%20%3Fmultipolygon_index%20(CONCAT(%22(%22%2CGROUP_CONCAT(CONCAT(%3Fcoordinate_string)%3B%20SEPARATOR%3D%22)%2C%20(%22)%2C%22)%22)%20AS%20%3Fpolygon_string)%0A%20%20%20%20%20%20WHERE%20%7B%0A%20%20%20%20%20%20%20%20SELECT%20%3Fname%20%3Fshort_name_fips%20%3Fshort_name_iso2%20%3Fshort_name_iso3%20%3Fmultipolygon_index%20%3Fpolygon_index%20(CONCAT(%22(%22%2CGROUP_CONCAT(CONCAT(%3Fwkt_coordinate)%3B%20SEPARATOR%3D%22%2C%20%22)%2C%22)%22)%20AS%20%3Fcoordinate_string)%0A%20%20%20%20%20%20%20%20WHERE%20%7B%0A%20%20%20%20%20%20%20%20SERVICE%20%3Cx-sparql-anything%3Alocation%3A%3E%20%7B%0A%20%20%20%20%20%20%20%20%20%20fx%3Aproperties%20fx%3Alocation%20%22https%3A%2F%2Fraw.githubusercontent.com%2FleakyMirror%2Fmap-of-europe%2Frefs%2Fheads%2Fmaster%2FGeoJSON%2Feurope.geojson%22%20%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20fx%3Amedia-type%20%20%22application%2Fjson%22%20.%09%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Fs%20xyz%3Atype%20%22Feature%22%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20xyz%3Ageometry%20%3Fgeom%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20xyz%3Aproperties%20%3Fprops.%0A%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Fprops%20xyz%3ANAME%20%3Fname%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20xyz%3AFIPS%20%3Fshort_name_fips%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20xyz%3AISO2%20%3Fshort_name_iso2%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20xyz%3AISO3%20%3Fshort_name_iso3.%0A%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Fgeom%20xyz%3Atype%20%3Fwkt_type%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20xyz%3Acoordinates%20%3Fmulti_polygon_collection.%0A%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Fmulti_polygon_collection%20%3Flist_multipolygon_element%20%3Fmulti_polygon.%0A%20%20%20%20%20%20%20%20%20%20%20%20BIND%20(xsd%3Ainteger(replace(STR(%3Flist_multipolygon_element)%2C'http%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23_'%2C''))%20AS%20%3Fmultipolygon_index)%0A%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Fmulti_polygon%20%3Flist_polygon_element%20%3Fpolygon%20.%0A%20%20%20%20%20%20%20%20%20%20%20%20BIND%20(xsd%3Ainteger(replace(STR(%3Flist_polygon_element)%2C'http%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23_'%2C''))%20AS%20%3Fpolygon_index)%0A%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Fpolygon%20%3Flist_coordinate_element%20%3Fcoordinate%20.%0A%20%20%20%20%20%20%20%20%20%20%20%20BIND%20(xsd%3Ainteger(replace(STR(%3Flist_coordinate_element)%2C'http%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23_'%2C''))%20AS%20%3Fcoordinate_index)%0A%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Fcoordinate%20rdf%3A_1%20%3Flongitude%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20rdf%3A_2%20%3Flatitude.%0A%0A%20%20%20%20%20%20%20%20%20%20%20%20BIND%20(CONCAT(str(%3Flongitude)%2C%20%22%20%22%2C%20str(%3Flatitude))%20AS%20%3Fwkt_coordinate)%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20FILTER%20(str(%3Fwkt_type)%20%3D%20%22MultiPolygon%22)%0A%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20GROUP%20BY%20%3Fname%20%3Fshort_name_fips%20%3Fshort_name_iso2%20%3Fshort_name_iso3%20%3Fmultipolygon_index%20%3Fpolygon_index%0A%20%20%20%20%20%20%20%20ORDER%20BY%20%3Fcoordinate_index%20%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20GROUP%20BY%20%3Fname%20%3Fshort_name_fips%20%3Fshort_name_iso2%20%3Fshort_name_iso3%20%3Fmultipolygon_index%0A%20%20%20%20%20%20ORDER%20BY%20%3Fpolygon_index%20%0A%20%20%20%20%7D%0A%20%20%20%20GROUP%20BY%20%3Fname%20%3Fshort_name_fips%20%3Fshort_name_iso2%20%3Fshort_name_iso3%0A%20%20%20%20ORDER%20BY%20%3Fmultipolygon_index%20%0A%20%20%7D%0A%7D&endpoint=https%3A%2F%2Flinked-data.goelff.be%2Fsparql.anything&requestMethod=POST&tabTitle=Query&headers=%7B%7D&contentTypeConstruct=application%2Fn-triples%2C*%2F*%3Bq%3D0.9&contentTypeSelect=application%2Fsparql-results%2Bjson%2C*%2F*%3Bq%3D0.9&outputFormat=geo&outputSettings=%7B%7D`,
  },
  {
    title: 'Made by',
    caption: 'Thibaut Goelff',
    icon: 'person',
    link: 'https://www.linkedin.com/in/thibautgoelff/',
  },
];

const leftDrawerOpen = ref(false);

function toggleLeftDrawer() {
  leftDrawerOpen.value = !leftDrawerOpen.value;
}
</script>
