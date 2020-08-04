<template>
  <!-- 
 The most basic form of data binding is text interpolation 
 using the '{{ }}' syntax (double curly braces) ref : https://vuejs.org/v2/guide/syntax.html
 in template we are using element.io Components use ref : https://element.eleme.io/#/en-US/component/button 
 check for event Handling for @click in line 10 ref: https://vuejs.org/v2/guide/events.html
 -->
  <div>
    8th chapter - TJ {{ cfMsg }}
    <el-button style="padding: 3px;" type="success" plain @click="mfOpenCtInCl">A</el-button>
  </div>
</template>
<script>
import ormHelloWorld from '@/cts/book/c07-element-orm-connect-many-rows/db/vuex-orm/helloworld.js'
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
  },
  mounted() {
    /**
     * mounted function is called at the time of component initialization
     * due to this the ormHelloWorld model will store the following data
     * in vuex store by ORM
     */
    ormHelloWorld.insert({ data: { id: 1, msg: 'John' } })
    console.log(ormHelloWorld)
  },
  methods: {
    /**
     * this will trigger the follwing function mentioned in
     * ptclient/cts/core/manage-cl-tabs/vst-of-tabs-and-dialog-in-cl.js:67
     */
    mfOpenCtInCl() {
      this.$store.commit('mtfShowNewFirstTabInClFromSearchPhrase', {
        searchTerm: 'Eight chapter tj - change',
      })
    },
  },
}
</script>
