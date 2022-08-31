import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "upcoming", "previous"]

  connect() {
    this.upcoming()
  }

  upcoming() {
    this.upcomingTarget.style.display = "block"
    this.previousTarget.style.display = "none"
  }

  previous() {
    this.previousTarget.style.display = "block"
    this.upcomingTarget.style.display = "none"
  }

}
