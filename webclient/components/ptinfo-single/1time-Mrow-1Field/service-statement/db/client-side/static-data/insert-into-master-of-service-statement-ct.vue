<!-- Reference implementation -->
<!-- To understand how this works call-insert-search-phases-of-components-and-handle-selection.vue -->
<template>
  <div></div>
</template>

<script>
import clientSideTblOfMasterServiceStatement from '@/components/ptinfo-single/1time-Mrow-1Field/service-statement/db/client-side/structure/master-table-of-service-statements.js'

export default {
  data() {
    return {}
  },
  mounted() {
    let i = 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: '60',
        serviceStatementCategory: 'Total minutes in psychotherapy',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: '55',
        serviceStatementCategory: 'Total minutes in psychotherapy',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: '50',
        serviceStatementCategory: 'Total minutes in psychotherapy',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: '45',
        serviceStatementCategory: 'Total minutes in psychotherapy',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: '40',
        serviceStatementCategory: 'Total minutes in psychotherapy',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: 'Client Centered',
        serviceStatementCategory: 'Modality of Psychotherapy',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: 'Dialectical Behavior therapy',
        serviceStatementCategory: 'Modality of Psychotherapy',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: 'Holistic Therapy',
        serviceStatementCategory: 'Modality of Psychotherapy',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: 'Existential humanistic',
        serviceStatementCategory: 'Modality of Psychotherapy',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: 'Bibilotherapy',
        serviceStatementCategory: 'Modality of Psychotherapy',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: '60',
        serviceStatementCategory: 'Total minutes with patient',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: '55',
        serviceStatementCategory: 'Total minutes with patient',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: '50',
        serviceStatementCategory: 'Total minutes with patient',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: '45',
        serviceStatementCategory: 'Total minutes with patient',
      },
    })

    i = i + 1
    clientSideTblOfMasterServiceStatement.insert({
      data: {
        serviceStatementMasterId: i,
        serviceStatementDescription: '40',
        serviceStatementCategory: 'Total minutes with patient',
      },
    })
  },
}
</script>
