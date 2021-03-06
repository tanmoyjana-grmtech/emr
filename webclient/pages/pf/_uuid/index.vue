<template>
  <!--  Prop explanation:
          v-on:mouseleave="mouseleave"
          Goal: Make it very easy to get the feed
          When the user takes the mouse to the left edge of the browser then bring the feed up
          Why not put it inside <SplitArea> the event does not get fired.
          Why not put a div inside and then put mouseleave event over there?
            when go from mtsvl to ptsvl the event gets fired.
        Ref: https://codepen.io/intotheprogram/pen/ZjxZdg 
    -->
  <div @mouseleave="mouseleave">
    <!-- Prop explanation:
        :gutterSize="0"
          This is thickness of the line between left and right panels. This line is used to adjust size of left and right
      -->
    <Split style="height: 900px; width: 1400px" :gutter-size="4">
      <SplitArea :size="65">
        <ctMtsVlCards></ctMtsVlCards>
      </SplitArea>
      <SplitArea id="ptsvl" :size="35">
        <ctCsVlCards></ctCsVlCards>
      </SplitArea>
    </Split>
    <!-- tab-dialog is present in patientFile.vue but in hidden state -->
    <ctTabsInDialogInCL></ctTabsInDialogInCL>
    <ctFeedDrawer></ctFeedDrawer>
    <ctMapDrawer></ctMapDrawer>
    <ctDeletedDrawer></ctDeletedDrawer>

    <el-dialog
      v-shortkey="['f1']"
      @shortkey.native="actOnF1ShortKeyPressed()"
      title="SC Brain"
      :visible.sync="currentVisibilityStatusOfScBrainDialog"
      width="30%"
      :before-close="actOnScBrainDialogClosed"
    >
      <el-input>This is a message</el-input>
    </el-dialog>
  </div>
</template>

<script>
import Vue from 'vue'

/* External Cts */

/* 1/4 Why needed? Split mtsvl and ptsvl  */
import VueSplit from 'vue-split-panel'

/*  2/4 Why needed?
  Say the user enter the rex command 10 times. I need to scroll to the bottom of the cards
  So search box is given a ID and then #manage-ptsvl-cards is used to scroll down.
  */
import VueScrollTo from 'vue-scrollto' // Ref: https://github.com/rigor789/vue-scrollto#as-a-vue-directive

/* 3/4 Why needed?
   Used to toggle between Health and Other components.
   Why not use element.io inbuilt switch?
   Read: src/components/common/TheMultiStateDisplayAreaHeader.vue:48
*/
import ToggleButton from 'vue-js-toggle-button' // Ref: http://vue-js-toggle-button.yev.io/

/* 4/4 Why use a different slider instead of slider from elemenet.io?
    Read: src/components/common/TheMultiStateDisplayAreaHeader.vue:23
*/
import VueSlider from 'vue-slider-component' // Ref: github.com/NightCatSama/vue-slider-component
import 'vue-slider-component/theme/default.css'

// Ref: https://github.com/MetinSeylan/Vue-Socket.io#-installation
import VueSocketIO from 'vue-socket.io'

// Internal Cts
import ctMtsVlCards from '@/components/core/mts-view-layer-cards/dynamic-list-of-cards.vue'
import ctCsVlCards from '@/components/core/pts-view-layer-cards/dynamic-list-of-cards.vue'
import ctTabsInDialogInCL from '@/components/core/edit-layer-tabs/show-add-and-remove-tabs-in-dialog-ct' // Name expands to Component tabs in dialog in change layer
import ctFeedDrawer from '@/components/ptinfo-combined/feed/drawer.vue'
import ctMapDrawer from '@/components/ptinfo-combined/map/drawer.vue'
import ctDeletedDrawer from '@/components/core/ct-deleted-rows/drawer.vue'
import clientSideTable from '~/components/ptinfo-single/1time-1row-mField/common-for-all-components/db/client-side/structure/table.js'

// Ref: https://github.com/MetinSeylan/Vue-Socket.io#-installation
Vue.use(
  new VueSocketIO({
    debug: true,
    connection: 'http://localhost:6001',
  })
)

Vue.component('VueSlider', VueSlider)

Vue.use(VueSplit)
Vue.use(VueScrollTo)
Vue.use(ToggleButton)

export default {
  components: {
    ctMtsVlCards,
    ctCsVlCards,
    ctTabsInDialogInCL,
    ctFeedDrawer,
    ctMapDrawer,
    ctDeletedDrawer,
  },
  data() {
    return {
      currentVisibilityStatusOfScBrainDialog: false,
    }
  },
  mounted() {
    // when page first loads the change layer tabs are set to not show
    this.$store.commit('mtfSetTabDialogVisibility', false)
    this.mfUpdateSocketClientId()
  },
  methods: {
    actOnScBrainDialogClosed() {
      this.currentVisibilityStatusOfScBrainDialog = false
      console.log('actOnScBrainDialogClosed')
    },
    actOnF1ShortKeyPressed() {
      this.currentVisibilityStatusOfScBrainDialog = !this.currentVisibilityStatusOfScBrainDialog
      console.log('Shortkey action')
    },
    mfUpdateSocketClientId() {
      console.log('Socker ID is', this.$socket.id)

      clientSideTable.insert({
        data: {
          fieldName:
            'clientSideSocketIdToPreventDuplicateUIChangeOnClientThatRequestedServerForDataChange',
          fieldValue: this.$socket.id,
        },
      })

      console.log(clientSideTable)
    },
    log(message) {
      console.log(message)
    },
    mouseleave(event) {
      // console.log('mouse leave', event)

      // How to identify which side the mouse left https://stackoverflow.com/a/48281888
      if (event.clientX <= 0) {
        // This is when the mouse leave from the left
        if (event.clientY <= 200) {
          // This is the top corner
          this.$store.commit('mtfSetFeedDrawerVisibility', true)
        }
      }
    },
  },
}
</script>
