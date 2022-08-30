import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "link"]

  connect() {
    console.log("Hello from our first Stimulus controller")
  }

  previous() {
    this.linkTarget.style.display = "none"
  }

  upcoming() {
    this.linkTarget.style.display = "block"
  }
}
