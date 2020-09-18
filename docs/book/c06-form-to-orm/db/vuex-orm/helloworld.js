// For docs read
// https://vuex-orm.org/guide/model/defining-models.html
// webclient/docs/models.md

import rowManage from "~/cts/core/crud/orm-row-manage.js";
export default class helloworld extends rowManage {
  static entity = "helloworld";
  static fields() {
    return {
      ...super.fields(),
      id: this.uid(),
      msg: this.string(null),
    };
  }
}