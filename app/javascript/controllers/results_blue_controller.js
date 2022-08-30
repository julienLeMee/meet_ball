import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="results-blue"
export default class extends Controller {
  static targets = ["badges"];

  connect() {
  }

  toggleBadges() {
    this.badgesTarget.style.display = "block";
  }
}
