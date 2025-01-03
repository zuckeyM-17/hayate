import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "links", "output" ]

  toggle() {
    this.linksTarget.classList.toggle('hidden')
  }
}
