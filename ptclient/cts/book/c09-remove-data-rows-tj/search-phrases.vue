<template>
  <div></div>
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
import ormSearchPhrasesOfCt from '@/cts/core/manage-ptsvl-cards/orm-search-phrases-of-ct'
export default {
  data() {
    return {}
  },
  mounted() {
    /**
     * mounted function is called at the time of component initialization
     * due to this the ormSearchPhrasesOfCt model will store the following data
     * in vuex store by ORM
     */
    ormSearchPhrasesOfCt.insert({
      data: {
        value: 'Ninth chapter tj',
        ctAbbr: 'c9',
        ctToShow: 'book/c09-remove-data-rows-tj/vl/table.vue', // CsVl -> Current state view layer
        displayLocation: 'ptsvl',
      },
    })
    ormSearchPhrasesOfCt.insert({
      data: {
        value: 'Ninth chapter tj - change',
        ctAbbr: 'c9-c',
        ctToShow: 'book/c09-remove-data-rows-tj/cl/table.vue',
        displayLocation: 'cl',
        ctWidthInCl: 'small',
      },
    })
  },
}
</script>
