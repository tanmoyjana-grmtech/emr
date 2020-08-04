<template>
  <!-- 
 The most basic form of data binding is text interpolation 
 for vue v-for with v-if ref : https://vuejs.org/v2/guide/list.html#v-for-with-v-if
 in template we are using element.io Components use ref : https://element.eleme.io/#/en-US/component/input 
 check for event Handling for @input in line 16 ref: https://vuejs.org/v2/guide/events.html
 -->
  <!-- 
   cfGetOrmNewRowsInEditState check for any ORM data row in edit state 
   if the data is present it will be displayed in the form 
   else the form will be created with empty row by line 27 mfAddEmptyRowInOrm function calling
  -->
  <div>
    Seventh chapter
    <el-form>
      <div v-if="cfGetOrmNewRowsInEditState.length">
        <el-form-item v-for="ormRow in cfGetOrmNewRowsInEditState" :key="ormRow.id">
          <el-col>
            <el-input
              placeholder="Please input"
              :value="mfGetField(ormRow.id, 'msg')"
              @input="mfSetFieldUsingCache($event, ormRow.id, 'msg')"
            ></el-input>
          </el-col>
        </el-form-item>
      </div>
      <p v-else>{{ mfAddEmptyRowInOrm() }}</p>
      <el-form-item>
        <el-button type="primary" plain @click="mfAddEmptyRowInOrm">Add more</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
/**
 * Q) Why we are using Vuex ORM
 * Vuex ORM  is used for "normalized" data schema within Vuex Store
 *  it provided normalized data with relationships such as "Has One" and "Belongs To Many"
 *  also it provides fluent API to get, search and update Store state.
 * ref : https://vuex-orm.org/guide/prologue/getting-started.html
 *
 * How :
 * To use orm first need to create a model for the ORM, which is preset in file mentioned in line 16
 * A models represent schema of the data which is going to be stored
 */
import ormHw from '../db/vuex-orm/helloworld.js' // Path without @ can be resolved by vsCode. Hence do not use webpack specific @ sign that represents src folder.

export default {
  computed: {
    cfGetOrmNewRowsInEditState() {
      /**
       * the function will provide all the row in edit state from ORM
       * ref : /cts/core/crud/rowstatus.js;147
       * */
      return ormHw.getAllNewRowsInEditState()
    },
  },
  methods: {
    async mfAddEmptyRowInOrm() {
      /**
       * Creates a empty row in the form
       * the functioned from the 'Add more' button and at the initilization of the form
       * when there is no data in edit state
       * mfAddEmptyRowInOrm function is called  in line 22
       *
       */
      const arFromORM = await ormHw.insert({
        data: {
          msg: '',
          vnRowStateInSession: 2, // For meaning of diff values read ptclient/cts/core/crud/forms.md
        },
      })
      if (!arFromORM) {
        console.log('FATAL ERROR')
      }
    },
    mfGetField(pOrmRowId, pFieldName) {
      /**
       * the function will provide the row in edit state from ORM
       * ref : /cts/core/crud/rowstatus.js;131
       * */
      const value = ormHw.getFieldValue(pOrmRowId, pFieldName)
      return value
    },
    mfSetFieldUsingCache(pEvent, pOrmRowId, pFieldName) {
      /**
       * the function will set the data in ORM
       * ref : /cts/core/crud/rowstatus.js;266
       * */
      const rowStatus = 24
      ormHw.setFieldValue(pEvent, pOrmRowId, pFieldName, rowStatus)
      this.$forceUpdate() // Not able to remove it. For the different methods tried read: cts/core/rowstatus.js:133/putFieldValueInCache
    },
  },
}
</script>
