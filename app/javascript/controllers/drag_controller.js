import ApplicationController from './application_controller'
import Sortable from "sortablejs"

export default class extends ApplicationController {
  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.end.bind(this),
      handle: ".js-sortable-handle",
      group: { name: "js-drag-list-group" },
      animation: 150,
      ghostClass: 'sortable-ghost',
    })
  }

  end(event) {
    let id = this.element.dataset.id
    let postId = this.element.dataset.post_id
    let url = this.data.get("url").replace(":id", id).replace(":post_id", postId)

    let data = new FormData()
    data.append("position", event.newIndex + 1)

    fetch(url, {
      method: "PATCH",
      credentials: "same-origin",
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token")
      },
      body: data
    })
  }
}
