<!-- To understand how this works read call-insert-search-phases-of-components-and-handle-selection.vue -->
<template>
  <div>
    <insertIntoMasterTblOfPhq9DuringInitOfCt />
  </div>
</template>

<script>
import clientSideTblOfCtSearchPhrases from '@/components/core/search-phrases/db/client-side/structure/search-phrases-of-components-table.js'
import insertIntoMasterTblOfPhq9DuringInitOfCt from './insert-into-master-of-phq9-ct'
export default {
  components: { insertIntoMasterTblOfPhq9DuringInitOfCt },
  data() {
    return {}
  },
  mounted() {
    clientSideTblOfCtSearchPhrases.insert({
      data: {
        value: 'phq9',
        ctAbbr: 'h',
        ctToShow: 'ptinfo-single/1time-1row-mField/phq9/view-layer/grid-with-cards-ct.vue',
        displayLocation: 'PresentTimeStateViewLayer',
      },
    })
    clientSideTblOfCtSearchPhrases.insert({
      data: {
        value: 'phq9 edit',
        ctAbbr: 'hc',
        ctToShow: 'ptinfo-single/1time-1row-mField/phq9/edit-layer/edit-design-1.vue',
        displayLocation: 'edit-layer',
        needsRowIdToWork: 'no',
        ctWidthInEditLayer: 'small',
      },
    })
  },
}
</script>
