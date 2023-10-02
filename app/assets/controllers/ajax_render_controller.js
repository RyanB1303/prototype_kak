import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ["place"]
  static values = {
    url: String
  }

  replace(e) {
    const id_param = e.detail.data.id
    if (id_param) {
      const url = this.urlValue + '/' + id_param

      fetch(url, { method: "get" })
        .then(response => response.text())
        .then(text => this.successResponse(text))
        .catch(error => this.errorResponse(error))
    }
  }

  successResponse(response) {
    const html = response
    const target = this.placeTarget
    target.innerHTML = html
  }

  errorResponse(response) {
    console.error(response)
  }
}
