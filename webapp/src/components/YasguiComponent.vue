<template>
  <div ref="yasgui"></div>
</template>

<script setup>
import '@triply/yasgui/build/yasgui.min.css';

import Yasgui from '@triply/yasgui';
import GeoPlugin from 'yasgui-geo-tg';
import { useTemplateRef, onMounted, watch } from 'vue';

Yasgui.Yasr.registerPlugin('geo', GeoPlugin);

const props = defineProps({
  query: {
    required: false,
    default: '',
  },
  endpoint: {
    required: false,
    default: 'https://linked-data.goelff.be/sparql.anything',
  },
  persistenceId: {
    required: true,
  },
});

const yasguiRef = useTemplateRef('yasgui');

onMounted(() => {
  const yasgui = new Yasgui(yasguiRef.value, {
    requestConfig: { endpoint: props.endpoint },
    persistenceId: props.persistenceId,
    yasr: {
      pluginOrder: ['table', 'response', 'geo'], // Enable geo plugin alongside default table
      defaultPlugin: 'geo',
    },
  });

  const tab = yasgui.getTab();
  tab.setQuery(props.query);
  const yasqe = tab.yasqe;
  yasqe.setSize(800, 500);

  watch(
    () => props.query,
    (newQuery) => {
      tab.setQuery(newQuery);
    },
  );
});
</script>
