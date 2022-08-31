import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="results-red"
export default class extends Controller {
  static targets = ["badges"];

  connect() {
    window.addEventListener("click", (event) => {
      if (event.target.contains(this.badgesTarget) && this.badgesTarget.style.display === "block") {
        this.badgesTarget.style.display = "none";
      }
    });

    setTimeout(() => {
      document.getElementById('flash-alert').style.display = "none";
    }, 4000);
  }

  toggleBadges() {
    this.badgesTarget.style.display = "none";
    this.badgesTarget.style.display = "block";
  }
}
