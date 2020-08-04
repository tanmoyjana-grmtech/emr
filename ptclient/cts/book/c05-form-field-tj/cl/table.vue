<template>
  <!-- 
 in template we are using element.io Components use
 ref : https://element.eleme.io/#/en-US/component/input 
 -->
  <div>
    From 5th chapter - Hello world TJ
    <el-input v-model="input" placeholder="Please input"></el-input>
  </div>
</template>
<script>
export default {
  /**
   * In vue a component’s data option must be a function,
   * so that each instance can maintain an independent copy
   * of the returned data object
   * ref : https://vuejs.org/v2/guide/components.html
   *
   */
  data() {
    return {
      input: '',
    }
  },
}
</script>
