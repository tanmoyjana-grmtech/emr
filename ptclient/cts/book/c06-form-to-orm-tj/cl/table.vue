<template>
  <!-- 
 The most basic form of data binding is text interpolation 
 in template we are using element.io Components use ref : https://element.eleme.io/#/en-US/component/input 
 check for event Handling for @input in line 13 ref: https://vuejs.org/v2/guide/events.html
 -->
  <div>
    From 6th chapter - TJ
    <el-input
      placeholder="Please input"
      :value="mfGetFieldValue(1, 'msg')"
      @input="mfSetFieldValueUsingCache($event, 1, 'msg')"
    ></el-input>
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
  methods: {
    mfGetFieldValue(pOrmRowId, pFieldName) {
      /**
       * the function will provide the row in edit state from ORM
       * ref : /cts/core/crud/rowstatus.js;131
       * */
      const value = ormHw.getFieldValue(pOrmRowId, pFieldName)
      return value
    },
    mfSetFieldValueUsingCache(pEvent, pOrmRowId, pFieldName) {
      /**
       * the function will set the data in ORM
       * ref : /cts/core/crud/rowstatus.js;266
       * */
      const rowStatus = 24 // 2 is new on client and 4 is changed on client
      ormHw.setFieldValue(pEvent, pOrmRowId, pFieldName, rowStatus)
      this.$forceUpdate() // Not able to remove it. For the different methods tried read: cts/core/rowstatus.js:133/putFieldValueInCache
    },
  },
}
</script>
