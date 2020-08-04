<template>
  <!-- 
 The most basic form of data binding is text interpolation 
 using the '{{ }}' syntax (double curly braces) ref : https://vuejs.org/v2/guide/syntax.html
 in template we are using element.io Components use ref : https://element.eleme.io/#/en-US/component/button 
 check for event Handling for @click in line 10 ref: https://vuejs.org/v2/guide/events.html
 -->
  <!-- 
   cfArForDisplayInTable function return  all the saved and unsaved data to el-table
    due to orm data is stored in state and it is updated live 
    in the view layer table on change on the change layer data updation.
  -->
  <div>
    10th chapter - component {{ cfMsg }}
    <el-button style="padding: 3px;" type="success" plain @click="mfOpenCtInCl">A</el-button>
    <el-table
      :data="cfArForDisplayInTable"
      :show-header="false"
      size="mini"
      style="width: 100%;"
      :stripe="true"
      :row-class-name="mfGetCssClassName"
      @selection-change="mfHandleSelectionForDiscontinue"
    >
      <el-table-column prop="msg"> </el-table-column>
    </el-table>
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
import ormHelloWorld from '@/cts/book/c10-system-versioned-vl-data/db/vuex-orm/helloworld.js'
export default {
  computed: {
    /**
     * data-bind to computed properties in templates just like a normal property.
     * Vue is aware that computed function depends on template data property,
     * so it will update any bindings that depend on computed function when v-data changes.
     * And the best part is that we’ve created this dependency relationship declaratively.
     * */
    cfMsg() {
      /**
       * Q) Why we are using Vuex ORM for form data store
       * Vuex ORM  is used for "normalized" data schema within Vuex Store
       * it provides fluent API to get, search and update Store state.
       * with this we can preserve the form data in the page ,
       * after reopening the form the form data will be present in the change layer(CL)
       * the ormHelloWorld ORM object referance is initiliazed in line 16
       * return : the cfMsg function will return the stored value by ORM
       *          in the template line 9 cfMsg variable
       */
      const arFromORM = ormHelloWorld.query().get()
      if (arFromORM.length > 0) {
        console.log(arFromORM)
        return arFromORM[0].msg
      }
      return ''
    },
    cfArForDisplayInTable() {
      // TODO: change this from Ar to Obj since JS ar has numerical indexes.
      const arFromORM = ormHelloWorld.getNotEmptyRows('msg')
      return arFromORM
    },
  },
  mounted() {
    /**
     * mounted function is called at the time of component initialization
     * due to this the ormHelloWorld model will store the following data
     * in vuex store by ORM
     */
    ormHelloWorld.insert({ data: { id: 1, msg: 'tj' } })
    console.log(ormHelloWorld)
  },
  methods: {
    /**
     * this will trigger the follwing function mentioned in
     * ptclient/cts/core/manage-cl-tabs/vst-of-tabs-and-dialog-in-cl.js:67
     */
    mfOpenCtInCl() {
      this.$store.commit('mtfShowNewFirstTabInClFromSearchPhrase', {
        searchTerm: 'Tenth chapter - change',
      })
    },
    mfHandleSelectionForDiscontinue(val) {
      console.log(val)
    },
    mfGetCssClassName(pRow, pIndex) {
      // set 'unsaved-data' class for 'Changed on client', 'form error on client side' types of row in view layer
      const dsRowStateInSession = pRow.row.vnRowStateInSession.toString()
      const lastCharecter = dsRowStateInSession.slice(-1)
      if (lastCharecter === '4' || lastCharecter === '6') {
        return 'unsaved-data'
      } else {
        return ''
      }
    },
  },
}
</script>
