<template>
  <div ref="yasgui"></div>
</template>

<script setup>
import '@triply/yasgui/build/yasgui.min.css'

import Yasgui from '@triply/yasgui'
import { useTemplateRef, onMounted } from 'vue'

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
})

const yasguiRef = useTemplateRef('yasgui')

onMounted(() => {
  const yasgui = new Yasgui(yasguiRef.value, {
    requestConfig: { endpoint: props.endpoint },
    persistenceId: props.persistenceId,
  })
  const tab = yasgui.getTab()
  tab.setQuery(props.query)
  const yasqe = tab.yasqe
  yasqe.setSize(800, 500)
})
</script>
