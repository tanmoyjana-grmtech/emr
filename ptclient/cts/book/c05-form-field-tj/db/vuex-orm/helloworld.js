// For docs read
// https://vuex-orm.org/guide/model/defining-models.html
// ptclient/docs/models.md

import { Model } from '@vuex-orm/core'
export default class helloworld extends Model {
  static entity = 'helloworld'
  static fields() {
    return {
      id: this.uid(),
      msg: this.string(null),
    }
  }
}
