<template>
  <div class="sc-mental-status-exam-all-content">
    <el-input placeholder="Filter text" v-model="userTypedKeyword" />
    <el-card
      shadow="hover"
      v-for="(allMentalStatusExamInsideAGroup,
      groupNameGivenAsIndex) in cfGetMasterRowsOfMentalStatusExamGrouped"
      :key="allMentalStatusExamInsideAGroup.id"
    >
      <div slot="header" class="clearfix">
        <span>{{ groupNameGivenAsIndex }}</span>
      </div>

      <div class="sc-mental-status-exam-all-content-body">
        <div v-for="ms in allMentalStatusExamInsideAGroup" :key="ms.mentalStatusExamMasterId">
          <div v-if="mfCheckIfThisExistsInChildTable(ms)">
            <div v-if="ms.mentalStatusExamFieldType === 'bool'">
              <el-button
                size="mini"
                @click="mfToggleMentalStatusExam(ms.mentalStatusExamMasterId)"
                type="primary"
                >{{ ms.mentalStatusExamDescription }}</el-button
              >
            </div>
            <div v-else>
              <el-input
                :placeholder="ms.mentalStatusExamDescription"
                v-model="descriptionModal[ms.mentalStatusExamMasterId]"
              ></el-input>
            </div>
          </div>
          <div v-else>
            <div v-if="ms.mentalStatusExamFieldType === 'bool'">
              <el-button size="mini" @click="mfToggleMentalStatusExam(ms.mentalStatusExamMasterId)">
                {{ ms.mentalStatusExamDescription }}
              </el-button>
            </div>
            <div v-else>
              <el-input
                size="mini"
                :placeholder="ms.mentalStatusExamDescription"
                v-model="descriptionModal[ms.mentalStatusExamMasterId]"
              ></el-input>
            </div>
          </div>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
import clientSideTblOfMasterMentalStatusExam from '../db/client-side/structure/master-table-of-mental-status-exam.js'
import clientSideTblOfPatientMentalStatusExam from '../db/client-side/structure/patient-table-of-mental-status-exam.js'

export default {
  data() {
    return {
      userTypedKeyword: '',
      descriptionModal: [],
    }
  },
  computed: {
    cfGetMasterRowsOfMentalStatusExamGrouped() {
      console.log('cf called')
      const arOfObjectsFromClientSideMasterDB = clientSideTblOfMasterMentalStatusExam
        .query()
        .with('tblMentalStatusExamForPatientLink')
        .where('ROW_END', 2147483648000)
        .where((_record, query) => {
          query
            .where('mentalStatusExamCategory', (value) =>
              value.toLowerCase().includes(this.userTypedKeyword.toLowerCase())
            )
            .orWhere('mentalStatusExamDescription', (value) =>
              value.toLowerCase().includes(this.userTypedKeyword.toLowerCase())
            )
        })
        .get()

      // Apply rules given by doctors

      // Rule1: If one "Modality of Psychotherapy" exists PatientMentalStatusExam table then do not show others
      let modalityOfPsychotherapyExists = clientSideTblOfPatientMentalStatusExam
        .query()
        .with('tblMentalStatusExamMasterLink')
        .whereHas('tblMentalStatusExamMasterLink', (query) => {
          query.where('mentalStatusExamCategory', 'Modality of Psychotherapy')
        })
        .where('ROW_END', 2147483648000)
        .get()

      //  (query) => { query.where('mentalStatusExamCategory', 'Modality of Psychotherapy') })

      console.log('modalityOfPsychotherapyExists', modalityOfPsychotherapyExists)

      if (modalityOfPsychotherapyExists.length > 0) {
        for (let i = 0; i < arOfObjectsFromClientSideMasterDB.length; i++) {
          if (
            arOfObjectsFromClientSideMasterDB[i].mentalStatusExamCategory ===
            'Modality of Psychotherapy'
          ) {
            if (arOfObjectsFromClientSideMasterDB[i].tblMentalStatusExamForPatientLink !== null) {
              console.log('row is there in client table.')
            } else {
              console.log(
                'delete the row category=Modality of psychotherapy from array of SS allowed to be chosen by patient'
              )
              arOfObjectsFromClientSideMasterDB.splice(i, 1)
              i = i - 1
            }
          }
        }
      }

      // Rule2: If one Time in psychotherapy then do not show others
      let timeInPsychotherapyExists = clientSideTblOfPatientMentalStatusExam
        .query()
        .with('tblMentalStatusExamMasterLink')
        .whereHas('tblMentalStatusExamMasterLink', (query) => {
          query.where('mentalStatusExamCategory', 'Time in psychotherapy')
        })
        .where('ROW_END', 2147483648000)
        .get()

      console.log('timeInPsychotherapyExists', timeInPsychotherapyExists)

      if (timeInPsychotherapyExists.length > 0) {
        for (let i = 0; i < arOfObjectsFromClientSideMasterDB.length; i++) {
          console.log(arOfObjectsFromClientSideMasterDB[i])
          if (
            arOfObjectsFromClientSideMasterDB[i].mentalStatusExamCategory ===
            'Time in psychotherapy'
          ) {
            if (arOfObjectsFromClientSideMasterDB[i].tblMentalStatusExamForPatientLink !== null) {
              console.log('row is there in client table.')
            } else {
              console.log(
                'delete the row where category=Time in psychotherapy from array of SS allowed to be chosen by patient'
              )
              arOfObjectsFromClientSideMasterDB.splice(i, 1)
              i = i - 1
            }
          }
        }
      }

      // Rule3: If one Time in psychotherapy then do not show others
      let totalTimeWithPatientExists = clientSideTblOfPatientMentalStatusExam
        .query()
        .with('tblMentalStatusExamMasterLink')
        .whereHas('tblMentalStatusExamMasterLink', (query) => {
          query.where('mentalStatusExamCategory', 'Total time with patient')
        })
        .where('ROW_END', 2147483648000)
        .get()

      console.log('timeInPsychotherapyExists', totalTimeWithPatientExists)

      if (totalTimeWithPatientExists.length > 0) {
        for (let i = 0; i < arOfObjectsFromClientSideMasterDB.length; i++) {
          console.log(arOfObjectsFromClientSideMasterDB[i])
          if (
            arOfObjectsFromClientSideMasterDB[i].mentalStatusExamCategory ===
            'Total time with patient'
          ) {
            if (arOfObjectsFromClientSideMasterDB[i].tblMentalStatusExamForPatientLink !== null) {
              console.log('row is there in client table.')
            } else {
              console.log(
                'delete the row where category=Time in psychotherapy from array of SS allowed to be chosen by patient'
              )
              arOfObjectsFromClientSideMasterDB.splice(i, 1)
              i = i - 1
            }
          }
        }
      }

      // End: Now group the SS

      const ar = this.groupBy(arOfObjectsFromClientSideMasterDB, 'mentalStatusExamCategory')

      // console.log(ar)
      return ar
    },
  },
  methods: {
    groupBy(data, key) {
      // Ref: https://gist.github.com/robmathers/1830ce09695f759bf2c4df15c29dd22d
      // `data` is an array of objects, `key` is the key (or property accessor) to group by
      // reduce runs this anonymous function on each element of `data` (the `item` parameter,
      // returning the `storage` parameter at the end
      return data.reduce(function (storage, item) {
        // get the first instance of the key by which we're grouping
        var group = item[key]

        // set `storage` for this instance of group to the outer scope (if not empty) or initialize it
        storage[group] = storage[group] || []

        // add this item to its group within `storage`
        storage[group].push(item)

        // return the updated storage to the reduce function, which will then loop through the next
        return storage
      }, {}) // {} is the initial value of the storage
    },
    mfCheckIfThisExistsInChildTable(pSS) {
      // I am able to get the data from child table.
      if (pSS.tblMentalStatusExamForPatientLink) {
        if (pSS.tblMentalStatusExamForPatientLink.ROW_END === 2147483648000) {
          return true
        }
      }
      return false
    },
    mfToggleMentalStatusExam(pMentalStatusExamMasterId) {
      const exists = clientSideTblOfPatientMentalStatusExam
        .query()
        .where('mentalStatusExamMasterId', pMentalStatusExamMasterId)
        .where('ROW_END', 2147483648000)
        .get()
      if (exists.length > 0) {
        clientSideTblOfPatientMentalStatusExam.update({
          where: exists[0].clientSideUniqRowId,
          data: {
            ROW_END: Math.floor(Date.now()),
          },
        })
      } else {
        clientSideTblOfPatientMentalStatusExam.insert({
          data: {
            mentalStatusExamMasterId: pMentalStatusExamMasterId,
            ROW_START: Math.floor(Date.now()),
          },
        })
      }
    },
  },
}
</script>
<style>
/* Goal: When less space display 1 card in a row. When more space display 100 cards in a row. */
.sc-mental-status-exam-all-content-body {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  /* Some other grid-template-columns options are :
  grid-template-columns: repeat(auto-fit, minmax(32rem, 1fr));
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  grid-template-columns: repeat(auto-fit, max(200px)); compared to minmax(200px, 1fr) there is more magin between cols and less content fits.
  */
  grid-gap: 8px;
  grid-auto-flow: row; /* This is default value */
  margin: 0px;
}

/* Goal: add space between two content card*/
.sc-mental-status-exam-all-content .el-card {
  margin: 5px 0px !important;
}

/* Goal: remove extra white space from sc-mental-status-exam-all-content header*/
.sc-mental-status-exam-all-content .el-card__header {
  padding: 10px !important;
}

/* Goal: remove extra white space from sc-mental-status-exam-all-content body*/
.sc-mental-status-exam-all-content .el-card__body {
  padding: 8px !important;
}
</style>
